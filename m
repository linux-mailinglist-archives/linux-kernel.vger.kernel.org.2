Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9C9454D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbhKQSt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:49:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:21855 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240176AbhKQStZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:49:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="257801340"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="gz'50?scan'50,208,50";a="257801340"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 10:46:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="gz'50?scan'50,208,50";a="454755271"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2021 10:46:06 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mnPwc-00024D-3U; Wed, 17 Nov 2021 18:46:06 +0000
Date:   Thu, 18 Nov 2021 02:45:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Alexander Duyck <alexanderduyck@fb.com>
Subject: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
Message-ID: <202111180219.YkyoBMpf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
head:   d31c3c683ee668ba5d87c0730610442fd672525f
commit: d31c3c683ee668ba5d87c0730610442fd672525f [1/1] x86/csum: Rewrite/optimize csum_partial()
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=d31c3c683ee668ba5d87c0730610442fd672525f
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip x86/core
        git checkout d31c3c683ee668ba5d87c0730610442fd672525f
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/um/../lib/csum-partial_64.c: In function 'csum_partial':
>> arch/x86/um/../lib/csum-partial_64.c:98:12: error: implicit declaration of function 'load_unaligned_zeropad' [-Werror=implicit-function-declaration]
      98 |   trail = (load_unaligned_zeropad(buff) << shift) >> shift;
         |            ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/load_unaligned_zeropad +98 arch/x86/um/../lib/csum-partial_64.c

    23	
    24	/*
    25	 * Do a checksum on an arbitrary memory area.
    26	 * Returns a 32bit checksum.
    27	 *
    28	 * This isn't as time critical as it used to be because many NICs
    29	 * do hardware checksumming these days.
    30	 *
    31	 * Still, with CHECKSUM_COMPLETE this is called to compute
    32	 * checksums on IPv6 headers (40 bytes) and other small parts.
    33	 * it's best to have buff aligned on a 64-bit boundary
    34	 */
    35	__wsum csum_partial(const void *buff, int len, __wsum sum)
    36	{
    37		u64 temp64 = (__force u64)sum;
    38		unsigned odd, result;
    39	
    40		odd = 1 & (unsigned long) buff;
    41		if (unlikely(odd)) {
    42			if (unlikely(len == 0))
    43				return sum;
    44			temp64 += (*(unsigned char *)buff << 8);
    45			len--;
    46			buff++;
    47		}
    48	
    49		while (unlikely(len >= 64)) {
    50			asm("addq 0*8(%[src]),%[res]\n\t"
    51			    "adcq 1*8(%[src]),%[res]\n\t"
    52			    "adcq 2*8(%[src]),%[res]\n\t"
    53			    "adcq 3*8(%[src]),%[res]\n\t"
    54			    "adcq 4*8(%[src]),%[res]\n\t"
    55			    "adcq 5*8(%[src]),%[res]\n\t"
    56			    "adcq 6*8(%[src]),%[res]\n\t"
    57			    "adcq 7*8(%[src]),%[res]\n\t"
    58			    "adcq $0,%[res]"
    59			    : [res] "+r" (temp64)
    60			    : [src] "r" (buff)
    61			    : "memory");
    62			buff += 64;
    63			len -= 64;
    64		}
    65	
    66		if (len & 32) {
    67			asm("addq 0*8(%[src]),%[res]\n\t"
    68			    "adcq 1*8(%[src]),%[res]\n\t"
    69			    "adcq 2*8(%[src]),%[res]\n\t"
    70			    "adcq 3*8(%[src]),%[res]\n\t"
    71			    "adcq $0,%[res]"
    72				: [res] "+r" (temp64)
    73				: [src] "r" (buff)
    74				: "memory");
    75			buff += 32;
    76		}
    77		if (len & 16) {
    78			asm("addq 0*8(%[src]),%[res]\n\t"
    79			    "adcq 1*8(%[src]),%[res]\n\t"
    80			    "adcq $0,%[res]"
    81				: [res] "+r" (temp64)
    82				: [src] "r" (buff)
    83				: "memory");
    84			buff += 16;
    85		}
    86		if (len & 8) {
    87			asm("addq 0*8(%[src]),%[res]\n\t"
    88			    "adcq $0,%[res]"
    89				: [res] "+r" (temp64)
    90				: [src] "r" (buff)
    91				: "memory");
    92			buff += 8;
    93		}
    94		if (len & 7) {
    95			unsigned int shift = (8 - (len & 7)) * 8;
    96			unsigned long trail;
    97	
  > 98			trail = (load_unaligned_zeropad(buff) << shift) >> shift;
    99	
   100			asm("addq %[trail],%[res]\n\t"
   101			    "adcq $0,%[res]"
   102				: [res] "+r" (temp64)
   103				: [trail] "r" (trail));
   104		}
   105		result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
   106		if (unlikely(odd)) { 
   107			result = from32to16(result);
   108			result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
   109		}
   110		return (__force __wsum)result;
   111	}
   112	EXPORT_SYMBOL(csum_partial);
   113	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--CE+1k2dSO48ffgeK
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICAxJlWEAAy5jb25maWcAnFxbc9u4kn4/v4KVeZmp2swkdpJKdssPEAiKOOItAKiLX1iK
rCSqsS0fSZ7Lv99u8AaSDWd2X2as7sat0ej+ugHmp3/9FLDny/Fheznstvf3fwff9o/70/ay
vwu+Hu73/xOEeZDlJhChNL+CcHJ4fP7rt+eH4P2vbz/8+ub1afc2WOxPj/v7gB8fvx6+PUPj
w/HxXz/9i+dZJOcV59VSKC3zrDJibW5efdvtXn8Kfg73Xw7bx+DTr9fQzdXVL/Vfr5xmUldz
zm/+bknzvqubT2+u37zpZBOWzTtWR2badpGVfRdAasWurt+/uWrpSYiisyjsRYFEizqMN85s
OcuqRGaLvgeHWGnDjOQDXgyTYTqt5rnJSYbMoKmYsLK8KlQeyURUUVYxY1QvItXnapUrnATs
wE/B3O7mfXDeX56f+j2ZqXwhsgq2RKeF0zqTphLZsmIK1ilTaW7eXn2Ebhr+SiiVq+BwDh6P
F+yz00nOWdIq5dUrilyx0l3mrJSgR80S48iHImJlYuw8CHKca5OxVNy8+vnx+Lj/pRPQK+as
Qm/0UhZ8QsD/c5P09CLXcl2ln0tRCpraN+l1wAyPK8slFMFVrnWVijRXG9waxmO3calFImdu
u47FSjhhRI8xWwrYDxjTSuCEWJK0+wv7HZyfv5z/Pl/2D/3+zkUmlOTWHHScr+wc9o93wfHr
qMm4BYc9W4ilyIxuxzCHh/3pTA0DFr0AIxIwhOkVCPYZ31Y8T1MwBmfxQCxgjDyUnFhn3UqG
iRj11P+M5TyulNAwbgpG5S5qMsfOzoqoXQf8OVhENzFgVI1eh1vTdD5s2NmJEiItDEwyE7U5
Ozbk8NrheVH+Zrbn34MLzDXYQtfny/ZyDra73fH58XJ4/DZSLDSoGOd5mRmZzZ2jo0N0AFyA
pQHfuDoe86rlNWlthukFuiRNcgstSUX8gyXYpSpeBpoyl2xTAc+dMPysxBrsgrJ9XQu7zXXb
vpnScKjOkS3qPxzXtui2JufuBOQiFiwEcyLdGjoqMI5YRuAK3/XbKzMDPp1FYixzXWtA777v
757v96fg6357eT7tz5bcTJrgjnw89A+ed+D6ZVokkoODjsBOTazych7fvHq9Ojw83R92h8vr
rxC/L99Px+dv32/e93F0DpKFdpcM7onPieXOkkUj7gxsf1eax8Kx74hJVQ05Xe88gkDKsnAl
QxOT5qWM25YUaYYtZEhbaMNXYcooL1xzIziFt0JNFhOKpeRiQgbrHh+nhpNKzV+aRihmJaVQ
DFa6YHAa+8FKAxHc+Y2BKdOjIKGARJ9MGY5Y7VDCjLoB3fJFkYMloc80uRJkj3YPbHC2a6FO
4UbDloYCnBpnZrjZY161vKK3XCRsQ3LQ6GBDbMxXtDHM8txU9d/0LvAqLyAmyFtARLnCKAP/
S1nGyRA9ktbwxwArDDCCDb+lDN9+cJft9VitZHvSALZI3M/BAKCxPoy3JyqGI5NMYEgX6Qae
x4VRjo8TSQRqUk4nM6ZhkeVgoBJQ+OgnmNVoxTWZp8Wax+4IRe72peU8Y4kLmu18XYKFEi5B
x+B+HEAuHVAo86pUg1jHwqXUolWXowjoZMaUkq5qFyiySQenoKVVo+A+ZltNoZUauRTj02jh
Z0QbJ8xDhOHQjVlf32RFxf709Xh62D7u9oH4Y/8I4ZJBFOAYMAGyuGHhH7Zo575Ma+1WFiIM
zATAV8EMwHzHVHTCZoOjm5Qz6rSDGGhXzUWLu4eNgIt+NZEa/ArYbJ7SbmUgGDMVAsCkNajj
MoogmSkYjAn7AUmDGWYZvfuzeQ9YCAlPhsmO1WyZJq/PT/vd4ethFxyfMDM994AEuI5FpQ7W
AOQp84GhWkqRQ+xK3WQD4TK4v0qXBTIddQP2XxgFzn/K68A2g2xAgd8EVYN/dM7g7c3bPr3N
FMYmffO2OxWYDiBM4JBfCEwwRevG7Krj4/kSPJ2Ou/35fDwFl7+farQ2wCLtshcfSVWnhSfm
pehiaC+fwsalhE116y0cFa8/fkCYI1SWh6JZSQ2iPrgiyVs/z2g+7K9xWB/ejcn5ckhJIdyk
ZWoxdsRSmWxuPnTwTrLrqyoScIAGoQBlYSvtpAkyS8MpMd7MbRI0InM4tqxUU8ZtzPK1zFyE
+8PNdKwZ19Z3+uHdTJrhul3NXFcJ+I+kKuaGzRIXo7T7Fa8EpFxDB2DrGLamQQFmSOm5kpD5
hBtn2QNypcA1xY6tQ1YfuZ4d/q9zNxSmbC5t9q4+O84eDAcmb49ZlYN7UTdXjiXCIYUQTUyx
WW29dn1z7Xh60B/GrwpOLeqlObakqyH9SutxAv59e9ruwFkH4f6Pw27vuBxtYKaqmqxRa8ek
MojYgN+Yo0LreUYksxlRzISyhvOVjmjwvwpgcV6TX329++83/wX/efvKFah5T5fzK2eGBBWV
piH+hDcPnSDxs8KyyBCb4L5jSSMHUVevhPY6xWb7y5/H0+9TteI0AAI7MLsmVMLEgNRcj91y
DARNiq4TSVBDJkbljJazFNwXrjqRkAKiLTflTBuq54IzCo87E1WF6ykoDfW9LqUyCLBSCgfZ
iKJLXQjYK4CeWs4G1llzJoRpilWkMC8hCnc9QMP8wtLpsJ5WK7YQGEup3KZIR71N8q2+OvcZ
Zr+C/ElEESTLiI4aFDPBZy1a2J523w+X/Q6d6eu7/RMoEzDXFCxwxXQ8smEN2+D6LoudrdsF
IAPgGDMrjsUY54xaSCDV5yhhcz3FBnW9T6dVmodN6XQ8QL1ZgiPKe4FVAVQyg9Rj3GQi2Lv5
hlOHXl9+m5i8LXG5k0BLG1WvMKQ4Dj0PSwg4iK1t0oK4e5C61vD1+goViS7ZZ7G2FG5LbU7K
gAxRxAJALEsgWgO8IDW4hBhRx4+eO6DVZsLz5esv2/P+Lvi9xucQi78e7ut6XY89XxAbDI2X
GEVSzmU2KGD+Q2tsu0IYiimauzKbwugU08o3I00Pqj+WhKkvx+oVCwnlNjJlhnxv45pNI8He
eH187Ecr3l0PjIuvI0lJGWDDRHtRWPJsjHHcuOPPbyXtgcaC69t/JHYL4fwlQcxmVlg+0ngG
unIQ1vLg0FO+DhpCkjPDbAhA0qvfzl8Oj789HO/Amr7su6g7Q1c5qPs2VZSZnvsuGPpCixFz
Jc3L5Zjb3JeutRJYgjRmmow5YquZ8fKa0pnMIeUWGffPphPkABh+LFUomXulNDjkvGC0paFA
feVWwYTUpoBwmU3CRrE9XQ54GAMDSHyQShUMIqyxxhwusfpEHi0d5roXdSolkRyQO9cwHtEt
19rQWN8E5X1Z2Yla6WfQSV3jCwULhxeKDnOxmbmhoiXPos8WnrVDRp+rVtFE8ba9YRpMpeuy
Vq0uZGY9B8B26QL6hq9glg3/JR7ZdgVmLXyNXeawdQ9irCbFX/vd82X75X5vr8ADW4y5ODqd
ySxKDUauQe1tCA3wVxWWadFdX2Kka+4aHKdd91WnRxMyFp57JI1dYo+ucfgma1eS7h+Op7+D
dPu4/bZ/IFENoBAzqHPoIoGgWxirJlt2eDcKzHx8LpwDMMdNQt82cgutQLzRcDhCVZkuO+1L
dZqqHbTaw4wO03bb/Obdm09dJSATYKiQ7FnIsRhgRZ4IOIeIYcj5RirPDF4e02Xl4d1CR78t
8pz2ILc2+uZ03QSvNmsNIQRc+PwmLMQWA8aXczUYgZNnBLjBx/3+7hxcjsH37R/7wOIzAKJg
FGgJdyBrxcPtZRuwHVYOgvT4eLgcTy1sabXL0vFeNobla9vy/bbV74tpj1STlUAHUwsEg1qI
gSHUlCqUjLKhMpNO/Rp/welxK8pRTczzQbnT0sZd9vehCY1T1hGkz1gCJrmYhS3EhpikzIZL
kkV9F4CpHm0dRRc0KnCwxjMiiBUZba44GVl48E3NnKNLEmm5puuwG0j783whBa2Luo+lkV5u
lJf0rJHJ6MtAywNY5GfKAt2OR8l2S11fj5k9L1rysKcyLPwmYCUUW/1AArmgRG1UTmMWHB3+
nL8EAjoZXs7cV0Gts2v5N692z18Ou1fD3tPwvfZchcH+fPCUc6Glb+PwxRCmfClTVFXP1iJM
gc+sAMhGG1evbWvw7DZTA7+VFj7fBsJ1qknjr+IFJhh+yD0rkHiTbGie8lwgG7Aq+h2OoS80
kivPCDMlwzkdX6y9aDqKLBOWVR/fXL39TLJDwaE1PZOE0+V3ZliyIDnrq/d0V6ygk4Uizn3D
SyEEzvv9O++a/ff6IfckJ6B2ZnEzyc4LkS31ShpOO5GlxldLntcsMCP7BM97rtPC4/3rS3V6
yFj7Y0I9U0iSvBLJdZVCKADQ4pP6rIx/gIyPX+i0mKVG5/bE+hIhR6Y+0ZSHss5wXc1KvamG
l76zz8korAeX/fkyAhZ2BgszFzS6mLQcMVyk4OicpYqFvmUxGpR6clCACWqtfE4gqhac9gPp
yNM05JVUIqkLff2MojkelLcTGNcxOhj3Zd9iN0TwQcq4FXDyuIaCwBCv/mKgrOtLvzeOt4sW
0lNHwQ355AG6TEY0QxRx5asnZBGtu0JDBEj8DlFGNC9ZmTLLBD37iMkkX5IXOsLEBgB5e8xb
26wL4EF4OvxRJ8R90fewa8hB3oHRHifWd+qxSOj7IzivJi3com9LqVIsdg5ugLOQJYP6aKHq
7iOp0hVT/cNBO4XocHr4c3vaB/fH7d3+5GRpK1upczN0sYY0ousHX8v2ymql66dE06UQkm1J
i1gxCNkUyk07xzPtwLcteGF5aJCsdprCPCVUcumZTyMglsqDQWsBTIGabiDdTMEw6BiPYgxg
LW+FbWnt5Qvq5nXYtDg7tZr6VenzObjrrqN6NxFLdJ6k83ObuLk1WP/4KmloFiNjZioNtH34
iG/vL6fjvb0YdlIyiS9Gvm7hHBSn4+W4O967Nev/V/t+wvM8n2MtuDHBybTN/ttpG3xtJ39n
J++O7xGY2Fi7bGfoTHvqyp56bB4Ru95UMqk6qr2BnSUUGm5FyllItQQyZlLUE+dWhMMR6Z5H
j3hJnhd9xcel2uKHvU+5+TgdNlQzKox365mFgzpeQ1aMDnKAJCt0t+hcXywCj0atUcEyFYF+
fno6ni4DSLDEu/Uxhm/jvtuoLl4dzjvqZIFTSTdYwCMnJjKe5LoEzwquzx5kOrJdja/269Kf
AA+RBufp5GtO9emarz+QCxg1bU7AX9szHKLz5fT8YB9ynb+DQd8Fl9P28Yxywf3hESwflnp4
wj+Hx+P/3Lp2C/dwaLdBVMyZc7iOfz6irw4ejliXDX4+7f/zfDjtYYAr/stgpTymAVaxLFgm
Obn6wWbVL6ARotYUR59taAQmXnW4B0gxGdqvWegd0xPI2z6mJgZyHALtDwxTc8S/o1exPUzp
o4ADXZoKb38K8iykC53WSN0Th/hwXjLPC1fxuWQJYDk/4jfCc1QBGGIq6asG+FjLtY+DsdAT
UGfg5suQBpFzT3oM89OCRoqwLl6/g6FKJGXm6g9+Vku7B/YLGw++XPr8VZaM6pw9eMR3RGa4
zwDRwlwBmGEcLw14TLNTduu6cJcF+5kZyWim4jRdu4VNh8HZUpYpzbKldnoccctj9ymLw6pD
N8mKS7YSkmTJj1fv1/QUR2/iHE4qccfyiFZxIgevkd12TC1F8kKf3sXVI4qUXkTGjJ8njMqz
PKU1k9GNPl5/ekMyCpFpfCBLMvHAIwYYeMB0VHOZNlNwODXTZJcKayCKZEFKpkv3XbXLyxOm
ooQpetU65xJSmDW9f4B08kJv6AktPQdgjU9414OKf7zxpZkp5PsNJp+E64Lr1vPfddC4vzed
crs0rChc5wI/8cupcZl5wA8FXpXRbgf5L9QukZ0Whb+tvRoYP6l0JXJ/WzYGmwOuTX6Moa4o
7Du3/pVeEnNXJcjtkkLfw22U0XBQ6QqLZaf4uBf/+jDZPXzY+vp8uNsHpZ61odtK7fd3TSEE
OW2tiN1tn/BV4ARNrBL3eSP+6lxqmBqx8PDM4NNM+Ol95zRslrqezmXNFOTSoDOay6XmOc0a
ec8xS2k5+ATVvpwki1BOw4n/HDBFKJlXM4R7ddmKDT9zHvAES7z9wjpohjY03Xjkbzeh6wNd
lg28IssG78lWbPqOYwXg9x4vN4Hpwt/VaoyLGncyaDAEZ1R1qn6U8fj0fPGiYJkVpbNy+7OK
Ivy2ZVxKrHm6YEqLReq5sK6FUmaUXI+F6ie05/3pHlP8Q5vXDzKrpn1ewoH3VKVrkX/nm5cF
xPJH/NFBc7Q1KdwNWi7EZpYDjO7V1lLgZC6GKXnHSRaLGe3COpFMrIznVUMno02+YivPd2y9
VJn9cLS1WZDpurMD7mtJfCdZ6CuCBBi10BR9tgkpcpLPJfy/KCgmBAtWGMnJDvnGhgKKZd8z
2C8Nh2/vWr5I8Ex6rm6c4QW6wXGCOR0tL3m8IL+V74Ui/JcHGuQ+6kMLJT0vwGqBpV6v14y+
tas3yH5B4LkdqwVwjporMb7+GO6z77NSlcp3k9y0jpnb053N5+VveYDexP20AD+udx/3wk/8
7+i7JEsGtFUbVB+tLV2xFR3LLReapKOn1H3d3IqQnpOadPdWjPKQtVPqPgO4G7/2B0AzfAHy
6SN+DeEYZyLmjG+8xKaOdu38+x+wF/aV+vjFa1bNNZ152xqh8byjrK2sfpM5LgO3yWr9IN+f
Aser5gs7Z7FpMqHBGPULLqeUghJwLktt7NezdZGf3JypmmtffMWpMhiSqV5ccUf6mrZvXaT0
9WU8rPF0QHYQC+HnFKnV+UChg939oa6VTSePDXliPwpY2A9VPbC5k7JW8SOheTE0+24mzb+k
czy5k6m5poB5Hne/TzEBvrN4+/7jx/of4nAujgZ0+wVznrHuJlbYy8OgyaMwxHsfZlyOMM19
cPm+D7Z3d/Zh6fa+ns7510H+NJmls36ZcaNoL4oK8WVz9ccZEEg87rPm40cRied1TSxU6nHf
9p9mCXP6kh/Lb4n3w1LFaX/LBXkMLH6ugPniR2Ju4/r28bR9+n7YDY2zvWMa8zqHPfh+Cm8Q
ecJk9+43luHUioA4SBhkiC8sIJPYAIhRIpt7ymQg6IsAZUy+E8Cum9uzdkYav4sDk8IGd2MU
h/Ls3TgyWypXw4dpLg/sQUwalJhteFrMRLKQTlaINA62ozZjmoRfm3HfEB/mjDYVZKcMP0en
LdQ2twbimVqPpAZtQPPzPFNS07k+iohUQ37gZyeCk9/fWuYtoM/xmHORzqSnJm35kaJjn2Um
OUR8T3BDgaVcMnChXj5MyAIlv8DGr4sV4LuczoPqscVK55PrCkdiLVnuC0O4uo1i3ofOKCA5
Iz/rszwzsdZ/s5miMSVyzUpmMaMq1LWiMvyAxIz+PSXgJNx6TG+/icjyJX2dU9vxXHKLel8Q
SbAo+gJ/EyVs+EjKYStR2/Xw1BFFYUvOsdoxNVNbH3vZVDLPs1TkgX8WdGkNuQUkJ+AYwJj9
56AQhiWbjH43awXAiyT8hQ4wBVJoj/7jUiiZMv8QmsmXltGUeP18kb7cvhDifyu7sua2kRz8
vr9CNU8zVU7iK479kAeeFmOKlHhIcl5UisyxVbEtlY7d8f76baDZJJsEmtqqJI4JsNknGo0G
PrisDRI52DuokuqFoPUyN67Ik0fj0CAwEtN6hMOUlQb8GkJL5I/40fiJLDAsByFQUo8xdgI9
h91RnIJoTC0pVKIRXz5EXRtrB4Ytx7Ta4LhP6hrkplsdwBo6QnWSSO1FPHQCuILJQgh5EjuW
Jl/EoSIFIDLm7m4mhAvjXCtjXgM7CLkwsyRzpPNhR+NyR5ad+40wgfrUALZsgD0kS5TvQYAN
00Otghu1zedCzx9zAEU542849TkChL9KhyPKnao89o28SANCm7pjSmGYgrG3y4xPOQ9dSZUX
pXJYy6Nvp7NH69Vus9/8fRgMP7bF7tN08Hws9gdKP+1jbej/QoJzZ16hn3iMRiAOKPec47j0
lhEzhpFOM4gqg4NRV4HHA0y6Oe7oSyKS3lgDVhDaMaWWBqJKeSN8W3MvROJgvHwuZGhWSuj7
PawSSK942xwKAP+g6k5Q5Vvbt/0z+YJGkMp67Az+LJ3A4veB87Le/jWokC3aDmdvr5tn8Tjd
OFTxFFn6yO02y6fV5o17kaRLX6L5+Iu/K4r9ain6ZrLZBROukD5W5F1/Hs25Ajq05sk6XB8K
SbWP69cnuIZSnUQUdfpL+NbkuHwVzWf7h6Q3Vk7sLHT1B1+eQ/T5P1yZFLXaTE6aFI1TO0Ay
TP3EY3yy5uDnQVtcESmVtpEy4nU8G3WaCt5gK1FLSnB1aE2bQIpePaCahSFxfzMePmpAlrWM
Kx1GgYGs5PARsX+zxIpSx2s7vFaFl12Pd53VKti+Lg8Qx6nfZp/A3eRtgGLq1hWHuT1KrO5m
bL0/7Tbrp2bLrchN4oAO/FXsjV2ZUWjB3a87jMMZ+LatwPmfMLqk7cgcpd1036pfQi840pDk
MXiIQcyEx4XBiNvW8JbWkQ68zAaGEG20YqJfeJUuv0J8yPHTdCBxoA5cAAzzMYY8JV3UBU3s
Kpbmei3W4CVEiDLr86pFqynXGsAJPoBLEkBOhDJb37jGiiF0oeXQVjrFlXpOzsIQIBN3Hf/D
drXvwu8sM/jl28p/vVr3AaD6pbJpDXFQPkboTMaKWLIAjKwYdp+WUY0PLObg00hy/UAGkjTn
Sfd+yo6knSX8i1EQGl71L/k3AeLTopQgbw7aj96L6pkEqVjEYzKmANDLgS7RHptforEXmhxC
mAakS4ufRnEmAxSV/Gk/COSDRQnKWRdrSQJR6iSPM82dAB9UYWW49n2LxBpFuM6Sf2YlUau1
ksCjGU0AA2B6YaBdcvXVkOvgXstPcSW/6c/ko7oXcGnTkwAcHMQZqUWWwmm5etFdCfyUiLpX
KrfkluzupyQefXGnLoq8WuKp4Urju5ubc63mP+Iw0KOrfwo2pta563capOpBf1ueQuP0i29l
X7w5/BtlrdrV+guieTDfnop3eZlrIEaZYRULWlta11uJqdpS6dgXx6cNYkV0Ohtlmq+hzYoH
DzquBT7rIOnDQ8Q2EMe0IIu1pYVEZxiEbuJRFk5A8mt+FRFy619VtFW9c2OwlXmTkTy86JV0
xIa6uSbqJLQT3xVHaM/SLbnyBzE6SvPqdm9VJNwwg9wT7cs8HaU2FmrivccPuuUaaD5PGxpJ
YIpidxJDbWyeZHjLSawRQ0onuZUOuVVk2AsBxnPOCqyRofVjnjaJ5tdG6g1PTUwfHRtQuB/T
KfdabujuJO4QlZwo73+ZGRcZJIyfMqDsEA7KjW7Aje3IxlAc5pLCiV2Ln9lc25pI0OKXCqn4
j/V+c3v79e7TRSMcEhjEZzyUT9dX3+hGN5m+ncT0jY6p15huv56fwkTH87eYTvrcCRW/vTml
Tje02tFiOqXiN7S5vMXEoAnoTKd0wQ0NgNFiuutnurs6oaS7Uwb47uqEfrq7PqFOt9/4fhJK
EMz9BY3nrBVzcXlKtQUXPwms1AkYJJhGXfj3FQffM4qDnz6Ko79P+ImjOPixVhz80lIc/ABW
/dHfmIv+1lzwzXmIg9sFE0amyDRID5BHlgNbGBMZpjgcD5CMeljEqShP6NNxxZTEVhb0fewx
CULOK1Qx3Vus42jFknjM7afiCBxwVKW3voonygPawqN1X1+jsjx5CBhgEeDJM59exXkUwPIk
9sQgXswmzaB1zYQkbf3F6rhbHz6oy7UH75HZv0szzcIdeSmaTLMkYKxcRpOOIpI7OkKjqiwB
eDh34vFjnQ1A8whos9Gfk0DlwAMxKAY8Bwm5VLfTaoTnheno+x/gMg/XRGfwDwTSnn0s35Zn
EE67Xb+f7Zd/F6LA9dMZuNU/Qw+f/dr+/YeWBuJluXsq3nUAtCZG3/p9fVgvX9f/bWXPw5Rs
EuS8DW6KJImcKg5Yqh2M2UQxA9Yhy6tDu7Wr1EpTQbSouj9oTzTVGrTsxOq2zNl9bA+bwWqz
Kwab3eCleN02QS8ks2jevdXMT6I9vuw8B2wU8qFmMiyfi6UqNjpGM5UsbfA3soCFG6SIKg+Q
EynxIfAVNn0FfzBad9nePBt6TKRXyYLIgG3bzPj463W9+vS7+BissL+fwdHwo7n2y9cTBqmq
JLu0uCqpntNLNxfvOUkPRzqidQXVhbk4ZFx+/Xpx1+kD63h4Kd4hwyXktfTesSMAUPU/68PL
wNrvN6s1kgD0kOgZh8ECKsn3ZrIztMSfy/NxHD5eXJ3Te7caZe8+SC8uaeGv+sGbBHRwTdWV
Q0us92mnH2y87H7bPOnGOlVP2zi7HJ926VVkxtJSkTmrQFllY+FhQjulluTYXLVxT8vm5rqJ
rXGWcBih5bCBk0WWG6cBeMR0h2S43L/wIyJ0BVORwx76vKfh09b70vS5fi72h44YdhLn6tIh
RBsSjLWYDy1G1yk57NB68C6NYyhZjOMkKpJdnLscllW5VvvqcsoqHbm0jl6RzW8HYn16Ifw0
sSUj94I5qStBMLTo81VNv/xKn2tqjq8XxsETHPSRpRLKZnIm9A2bcckveWbjVh3kSlhvX5TL
QltGGqeBhQlCzXMpnvmc+q0mkzXyxLHDuCEBmKtxpIHB2P+uuSk+/jxlbzHvF8lYHMfMo2ic
0Nks7uuvkqVMMtQdzc3bdlfs91K37XYDH1uvdoCfDOqfJN9eG2dx+NPYPkEeGtdiG+dfulmJ
Y8HmbRAd334VuzKBw4FuoBWlwcIZJ5x7W9kNiX2Prn4mph8BxHF44LLCnHwaiutCqMiLPolX
MaYPTjAe9qvDyNzTlorP8qxu15Wa/+v6124pThq7zfGwfie3wDCwT5H9wCbXQi8XqSZ2+dQ+
AFHrP73vgMVIlHbKblHXjdYBW3v6rDoeFbsDOFwJzVS6/OzXz++Y82uweilWv1sZSE5hR/7Q
0OvjLjJ5SbGDDLALk2ZkcpWHToj5yBHndR8wsvR8lxpP6EUtsnKkQnjmLGga9hXJDyDRUJBA
LKOOGO/ESSuZdN2QBDJ5RfnI9hhAKQdivhyxmsixcPSEn8BsVC6cRZDlC6asq9bZUzwQUjn0
2wc2nSEMHM9+vCVelRROpCGLlcx4iQocNmPHElTGFi8oLIG2jYqZL9VG7jX6nCPDV5k+qrjm
PwEkmei+KAZn8NYMFE/YxANIE6KKcyFyJ00YohAulTU7TDJBiFzizVR8STlilcu0s/p0K5Fa
1vh0u1u/H35jOOfTW7F/pgx3ZS7qdpakNh3i1RjJ3shUiWikCzLQz5FhyoAgINMGqju3byzH
JAc/jSqt4kicgOBaoVPCdV0XTPVbVtllcwa7j5EltGeD54zGwcG8pY8jOxZraeElCeTmaYZU
w2virxB4dpxq0KfsoFSKzvq1+IQZ0lHu7pF1JZ/vqCGUX2s7k5VEPxE1Q+eh7xfnl9fNYUsg
aUA6gnYwt9Fi70WzlMWk1oDvph4m9AD/hBEE0DahAnQK1mIRR2HDn0pWD8EfdIeqMicFJoqa
edaDytBBWhxP7jXNy75cNG7x6/j8DIbIBlbivxrIyVX2yDoVSwTd8v38nwuKS8buN5AuOjSw
weRe5Oi4u1UaDtJyb6cMsMxJzdHHTCa/bM9XzBbzoZmVq8L0TV6sQm+eQVQhYy6WBQIjn9AE
i4lnERdHD2QxMSAKk9EV5Vdi+4fHmYfKKRpaVKpivDQoOwQxc6yH7gxUFFPxaF7PQTjRAhJT
IUkuSHrIu4fK8qb8YpP+7miNbxipHVSQHiwxQxrB1DoVnDkwiVgsuIIMspfDfqYCiXXTfT3s
nbYOW8ip0uYD/IN4s92fDcLN6vdxK9ffcPn+3NIPI7EUhEyIab9OjQ7eyrlXJ6OTRNip4jxr
wpZDJCg4g+YAs5bx+TQlcTHMI0DwTOkxmE3MQACICi2/Ri5Hc1/IizSV3UpbX9pswd7W8FXg
cSerT31lQhTZHjvouQfPa6fXkEo9WHZr0fHnfrt+R0iHs8Hb8VD8U4j/FIfV58+f/6qrig66
WDZEXjWCmRraQzytHHVpHQ/KgHYZFkSdrdC0CokQrhZLfyGzmWQSIiOeQQo9U61mqcdsnJIB
m8bLv5oJOg8P0KW+SheKxYmpnQE6MavW1i0wKb+p4/cX5aSu/OjMCjJKWVIq6f8xdzpaS5nI
lFKvKr1Sx2JL8MpykUcQawvpjvgs8qUIlzuEeQfQlLWGUCuzcT5BOivYTledDOjlOAZML5Zb
YQ89Ne1w6FoecAdR3AOjhQug20JTTXLC+V2TTUyT2l91EtG9gEKrZzeRtisnp3UDQRCTywoN
0wpYeuceMCWef1JZSct5XqN6EwLtp45o1NrRkQaTUgFNCNVTrUqZfrKFJaH2ClE1XTIqtbcz
r8VCENuYL1vDHLRwZzAwDGeiNiaGOI2EQuWZWBDYqKcYqf7W2aaQk8mThLRFGlnjdBhTa9AW
61ecDcROgUEdbS8F9dyKxCoQfe2WLzBivGIH/H0TY5XONDZMoPQxyoYLTLlhaB6eXha2mAbD
dgasRr0wzXCAhwgIg+BFM6Y/6S654xulLXhWEj6WJ96mIqdxN00EmcyYgyqJs/l3sVs+F5oj
Tx5xHkqlFILjLiKL/vD4VI5yZpA8TbMK6q1OPO2oq0JJFY/LbNdj7d4Q+InyEsgUPZKyAtZc
O+Yd9TbIgQAh/rxm5wZTxn5lV2YO2FoNMsmGSysDHfJNpnEYQ0g6y4UHYqEAL8yFlekeWbqV
xaPAubk2qwPY8qE3h4QrjI0nQTnWW0jJKN2lmDVT8qUOcwGBDA+CI2NCKZEB5zxtTpVfcKzI
QJaWNZ6e5+0g1SZ1biUJY1xCOgQ7+UKF5DkSuFZBIEjDiHA3L0gNXC4yFQ4oD7RGpNoet1Eu
mvSpIQ2p7JwUU/6Yxs8emzo/FGtpGOMeQruioNEe0rebxSqWRmWQac0FjDcytIe3FZazFZ0B
WSdHOWNHsWHGiJO7I3ZVw4xDfTfgpK8qxMyA7nlgOaFPicY9oOOfJ23J/wOXlkW545cAAA==

--CE+1k2dSO48ffgeK--
