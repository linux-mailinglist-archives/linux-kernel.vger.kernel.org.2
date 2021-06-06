Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431B239CFAC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 17:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFFPDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 11:03:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:53165 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhFFPDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 11:03:09 -0400
IronPort-SDR: 0oaXFgNzl3BEnwKcQMpmEYX5EcUujwo8Aq/5KVcMY1RmaXFR2319RZgkh+kMuccKwxc0K2LUE0
 gMawi4bDC1oQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="202655074"
X-IronPort-AV: E=Sophos;i="5.83,253,1616482800"; 
   d="gz'50?scan'50,208,50";a="202655074"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 08:01:18 -0700
IronPort-SDR: lwWMQeOIwdyk1CLQq8Q4MkmVhlGJJBORLYF4sBbH4X0+wWwKqXPhcBdcEq4b8NWEWTa2ZDNhbg
 jXXoSxPH+pJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,253,1616482800"; 
   d="gz'50?scan'50,208,50";a="551647079"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jun 2021 08:01:16 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lpuH6-0007xv-9M; Sun, 06 Jun 2021 15:01:16 +0000
Date:   Sun, 6 Jun 2021 23:00:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     irqchip-bot for Marc Zyngier <tip-bot2@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
Subject: Re: [irqchip: irq/irqchip-next] powerpc: Drop dependency between
 asm/irq.h and linux/irqdomain.h
Message-ID: <202106062241.NcVGcvw3-lkp@intel.com>
References: <162298343129.29796.10381692252026350764.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <162298343129.29796.10381692252026350764.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi irqchip-bot,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on linux/master linus/master v5.13-rc4 next-20210604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/irqchip-bot-for-Marc-Zyngier/powerpc-Drop-dependency-between-asm-irq-h-and-linux-irqdomain-h/20210606-205106
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-sbc8548_defconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/72415db4cc9ec9987380123553c3222a3568f37f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review irqchip-bot-for-Marc-Zyngier/powerpc-Drop-dependency-between-asm-irq-h-and-linux-irqdomain-h/20210606-205106
        git checkout 72415db4cc9ec9987380123553c3222a3568f37f
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/sysdev/fsl_mpic_err.c: In function 'fsl_error_int_handler':
>> arch/powerpc/sysdev/fsl_mpic_err.c:111:17: error: implicit declaration of function 'irq_linear_revmap' [-Werror=implicit-function-declaration]
     111 |   cascade_irq = irq_linear_revmap(mpic->irqhost,
         |                 ^~~~~~~~~~~~~~~~~
   arch/powerpc/sysdev/fsl_mpic_err.c: In function 'mpic_err_int_init':
>> arch/powerpc/sysdev/fsl_mpic_err.c:131:9: error: implicit declaration of function 'irq_create_mapping' [-Werror=implicit-function-declaration]
     131 |  virq = irq_create_mapping(mpic->irqhost, irqnum);
         |         ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/irq_linear_revmap +111 arch/powerpc/sysdev/fsl_mpic_err.c

0a4081641d722d Varun Sethi      2012-08-08   95  
0a4081641d722d Varun Sethi      2012-08-08   96  static irqreturn_t fsl_error_int_handler(int irq, void *data)
0a4081641d722d Varun Sethi      2012-08-08   97  {
0a4081641d722d Varun Sethi      2012-08-08   98  	struct mpic *mpic = (struct mpic *) data;
0a4081641d722d Varun Sethi      2012-08-08   99  	u32 eisr, eimr;
0a4081641d722d Varun Sethi      2012-08-08  100  	int errint;
0a4081641d722d Varun Sethi      2012-08-08  101  	unsigned int cascade_irq;
0a4081641d722d Varun Sethi      2012-08-08  102  
0a4081641d722d Varun Sethi      2012-08-08  103  	eisr = mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EISR);
0a4081641d722d Varun Sethi      2012-08-08  104  	eimr = mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EIMR);
0a4081641d722d Varun Sethi      2012-08-08  105  
0a4081641d722d Varun Sethi      2012-08-08  106  	if (!(eisr & ~eimr))
0a4081641d722d Varun Sethi      2012-08-08  107  		return IRQ_NONE;
0a4081641d722d Varun Sethi      2012-08-08  108  
0a4081641d722d Varun Sethi      2012-08-08  109  	while (eisr) {
0a4081641d722d Varun Sethi      2012-08-08  110  		errint = __builtin_clz(eisr);
0a4081641d722d Varun Sethi      2012-08-08 @111  		cascade_irq = irq_linear_revmap(mpic->irqhost,
0a4081641d722d Varun Sethi      2012-08-08  112  				 mpic->err_int_vecs[errint]);
ef24ba7091517d Michael Ellerman 2016-09-06  113  		WARN_ON(!cascade_irq);
ef24ba7091517d Michael Ellerman 2016-09-06  114  		if (cascade_irq) {
0a4081641d722d Varun Sethi      2012-08-08  115  			generic_handle_irq(cascade_irq);
0a4081641d722d Varun Sethi      2012-08-08  116  		} else {
0a4081641d722d Varun Sethi      2012-08-08  117  			eimr |=  1 << (31 - errint);
0a4081641d722d Varun Sethi      2012-08-08  118  			mpic_fsl_err_write(mpic->err_regs, eimr);
0a4081641d722d Varun Sethi      2012-08-08  119  		}
0a4081641d722d Varun Sethi      2012-08-08  120  		eisr &= ~(1 << (31 - errint));
0a4081641d722d Varun Sethi      2012-08-08  121  	}
0a4081641d722d Varun Sethi      2012-08-08  122  
0a4081641d722d Varun Sethi      2012-08-08  123  	return IRQ_HANDLED;
0a4081641d722d Varun Sethi      2012-08-08  124  }
0a4081641d722d Varun Sethi      2012-08-08  125  
0a4081641d722d Varun Sethi      2012-08-08  126  void mpic_err_int_init(struct mpic *mpic, irq_hw_number_t irqnum)
0a4081641d722d Varun Sethi      2012-08-08  127  {
0a4081641d722d Varun Sethi      2012-08-08  128  	unsigned int virq;
0a4081641d722d Varun Sethi      2012-08-08  129  	int ret;
0a4081641d722d Varun Sethi      2012-08-08  130  
0a4081641d722d Varun Sethi      2012-08-08 @131  	virq = irq_create_mapping(mpic->irqhost, irqnum);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--YZ5djTAD1cGYuMQK
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICHrcvGAAAy5jb25maWcAjDxbc9s2s+/9FZp05sz3PaS1ZTtN5owfIBCUEJEEA4CS7ReO
Iiuppo7kI8lp8u/PLngDSEBOZ9pE2MXitvdd9vfffh+Rl9P+2+q0Xa+enn6Ovm52m8PqtHkc
fdk+bf53FIlRJvSIRVz/AcjJdvfy48/n/b+bw/N6dPPH5dUfF28P6/FovjnsNk8jut992X59
AQrb/e6333+jIov5tKS0XDCpuMhKze707ZuawtsnpPf263o9+s+U0v+OPvwBBN9Y07gqAXD7
sxmadqRuP1xcXVy0uAnJpi2oHSbKkMiKjgQMNWjjq+uOQhIh6iSOOlQY8qNagAtrtzOgTVRa
ToUWHRULwLOEZ6wDcfmpXAo570YmBU8izVNWajJJWKmE1B1UzyQjsM8sFvAfQFE4FS7699HU
vNzT6Lg5vTx3Vz+RYs6yEm5epbm1cMZ1ybJFSSQch6dc316NgUqzZZHmHFbXTOnR9jja7U9I
uD2/oCRpLuDNG99wSQr7DsyxSkUSbeHPyIKVcyYzlpTTB25tz4YkDykJQawVXDrtSSwi9kGG
cOE5Z8RiUiTa3Ja172Z4JpTOSMpu3/xnt99t/tsiqCWxDqPu1YLndDCAf1Kd2LvNheJ3Zfqp
YAXzbndJNJ2VA3jzbFIoVaYsFfK+JFoTOrOpF4olfOKlSwqQcA9Fc91EwpoGA3dMkqThOWDf
0fHl8/Hn8bT51vHclGVMcmq4W83E0hLfHqRM2IIlrjxEIiU8c8diISmLavbn2dS6y5xIxRDJ
nHSzexztv/Q21l/diNeiO0sPTIGP57CvTCsPMBWqLPKIaNbcgt5+2xyOvouYPZQ5zBIRp/Y7
ZAIhPEr8b2zAXsiMT2elZMqcQCoXpz76YDfNZnLJWJprIG80UMdz9fhCJEWmibz3Ll1j2TBz
eJoXf+rV8Z/RCdYdrWAPx9PqdByt1uv9y+603X3trkNzOi9hQkkoFbBW9ZDtEgsudQ9cZkTz
hf+akC/MS3boXryJimD3gjIQDUDVXiTUpEoTrfyHV9x7179weHNJkhYjNWQP2PJ9CTD7EuBn
ye6Aa3zSqCpke7pq5tdbcpeybmte/cV/lfMZyFWPo1qljto7BnHlsb69vO7YiWd6Dio9Zn2c
q+rUav335vHlaXMYfdmsTi+HzdEM1xv1QC37M5WiyP2PgRoXpB7e0wumM0bnuYDNoaRoIf3c
owAvMkbKLOXHuVexAm0PvE9B3iMvkmQJuffc2ySZw9SFsR0yci2vJCkQVqIArWbZFRn1zCAM
TGBg7Iy49hAG7h56cNH7fe38flA6sjluIgSI3YA5OudF5CBm/IGhFkZ9Bn+kJKOOEumjKfhL
yJyAIxChF0NFxEpQpKRk6IGgqIvMJnoW0ceqUSlkPiMZmEmZOfa2srPObxAzynJtnFJJqOWV
TfK4+1EJY/c7BcvPwZJKi96U6RQUSDkwKRUHDYZj2CNo/26gsvuVVrdGjYjZTpRl+FgSw8VI
e9sEDGFcOAsV4G/3fpY5t6jkwtkvn2YksV1gsyd7wBhGe0DNwOGw3GtusR8XZSEde02iBYdt
1ldiHRaITIiU3L7YOaLcp8px6OqxEv708EALNreBwokGxOH3PG6W9wo0vq3x7+LIQ9/4QujO
d/stkdSE0Ll1Gh+aus9o82TdcWiae5YBn+aTjRYxeHwz6t0zLMKiiPk2bEQOpbZsXZrOrtHL
i+uBSa9juXxz+LI/fFvt1psR+77ZgV0joLopWjbwMCrrX9PpyHvt5C9SbLa8SCtipbHrjkhg
YEI0RDWWWKiETOxTqaTwO7kqEROfVYX58E5yyhrP3qUG0Bi8n4QrMCkguCINULcRZ0RG4DL6
bYaaFXEM4VVOYE1gHoibwFAF/C4R82Tg29QX6wZ9rd7I6dXYeeecvhu+c37YrzfH4/4AzuLz
8/5wcp4U4hOwDPMrVV6NPZeG8Pc3P370linf//jhPcf1RWD8+oeHeutt545zxG5uLi5w0C8E
7zzQdubFRX+rOJbSwNli8EMlm1qsF6sE5cwweyos84LXxFy83pAhWA9fuc737F6V764n3uBL
5Qwtg+IT21bAqEs5TQtw6kHZzELj5dXYBVUbQQxnMzDBWCw/03oVVSbxxtXtpU0+EkJOWJLY
jumQ21pxj5SwN4ghwATfLIs4se75agzXZBmMtOjp2zQleSkzcJogUi1Tcnd7+dc5BIgyLy/9
CI2eeY2Qg+fQg4uBCEXd3lyO25eDgHxufI1SFXnuZnbMMMyIEzJVQzjGpOCJDgGNqMyWDKJD
7bxz79FrO5QJYCELxohM7gfORk6yOlQWBfj079s8V+U5i5Rr0Hbgi5fG2bbNdnVF5L62PcD7
UW8rRTSZlpfvQJytWZhgMHOHh3M8H2uwNfDNJix5bbI0BU9BzfZNM58wWTmSHhEzKKqAa4In
DoLNQ2AyQIoJU+4Bwc1pbLajRFwYJ1Tdjv2w6BxsAbD2QfJplSo0uRScU2n3p9UJra2l3C0F
pQRtlZQVKdMPl1eXECT47Scdf7iC5+T+iKqaPS4/RX79keb0/c31BRzjDPzdK/AfP0r6Cjw9
B796V74y/RVw6G7yy4vLi3PQ8ThEugLKaB6EXgUJ66U0GH7jCq8sIXD1LztXHO/bC7tjqjmx
n7C+K6f5lX9Ln1J85zOwyzOw92HYzU0Y5p6j2eUEOe69a/dJcBHwxXiaX/nzxOkiZWNwGPxv
BNL5iYH1ZCEMdPszphvd5X8Q8HunRS/j3nk3OcnhrYkkmCcLeC1goyFAvQP9zO0oL83dBCT+
riK7AK8DOFVTB9pk+0bxYfN/L5vd+ufouF49VQm+7pxgu8EH7kUpXbrMM7shzB+fNqPHw/b7
5gBD7XI43F9hmDq1VqgmWCM2YZtO6vNr4YFKqanjufQ1qR0l7Z+x1OVEQ5ilhbDPn8F9KC8v
fLwKgPGN46LCyFWAmyoqfjK3QKZ9d6Jn4LMWSZNa8Y43OYPu/V3wbFkWGUhGwlIIygIhzZzd
MT9bg4nG+AZNlF80JHqoUeF1L42pBZdIw4WCQ0gcO8yThE1J0tj+ckGSgll2EQTiem6CrJ4F
NnFXnaxsTWxdW2tzmI0bgXmnPq6pR6BjWD6IjAkI9aTl+tE0MmW+LrPH7sC/KzWBGBMi8G68
9jEs5752OjCOfDA+Vadza5Ca89zkEgIlgtax8emIFMJUxpwKGYxhGtSM+7VbWi7JHF9x7ksQ
52mPmvFR/NWrT/BWS3gpFscc/AgI8Wsv7VzaoBGx9tkVKaOUlMSoOCN5k5ejJYk9P7HGd1mA
Q3AhGdXoz7ixGxhNd2CAkaeONsWhZEK9R7A3ZnZKHr9j/uOxrdN2JbhogVnVyCRSRaYGyjfa
fFm9PJkBLC0cR6CURquG3touvTdrjlaHzejluHnsbiURS5QlTNDeXvwADWP+6UEpScusSG9b
KTASI+JYMQ2z1r1ZdREV4hvpA2OQyynpEC5CCCTh0wwRrl0EbbKr1ZZb6u0l9+7UrSgVQPNh
IA9OyXx1WP+9PW3WWIV4+7h5BrKb3WnIUJWm6mfwPoLmKhMC8W4o+9Zxe5GZE2LlgWJBqhdT
FIqZSrnmGbjTThHZEOKwNEaeEHHoHmjej0KqUcm0FwA85p9QjWK/QNzLiht4XGTUGAUmpYAI
N/vIqGtbuoqxmT+DIGMYuqGfgka8VrqevCloWM3j+6ZI4iKYTACyY9m/BmyySEVUNyH0T4ex
WElQh2IkXr9BrUccvCr7ag+ZFKcby3XjmDKuaaId811GxyXnoXbKujHH4FhOwSTDGlWgh8bB
C8bi4SsolelDSXKvdEmAPTFhYa6VwKMuIHKAmYO3gT1nKa8KfzTN7+hs2qfFyBzPwTAFT+in
gkv/csYUY/m+6SXxXI1iFJMsZ0BlDBLTs5UVJCSQ5qlQiIB5hV3I+aVx+CmFXdNItGiq6vYq
nnp2X56HJeweBvByfdacUR5zyzQBqEhAVFFpYDEIGcdDn92hqGRVywWeo4ejRKwRBihimfVR
Wnk0K5jkt8M73WM4ubVziTnLUaqFMuFVq1ObHvPRzxYSjJLI7WJAApdeYuVlSWRkAQT2GvHp
wLuqx0lPZdVJvEqr4Hv0tl8ZZDBPtZ2TyzvPDQFXcPAnHBwrYO4Bz5WWTFIYeMpxWjqxCZU5
3bRUlSlCcTcFhsZTmlKxePt5BS7B6J/KvXo+7L9sn5xGjXYniF2XIEyhwg6LzlFyng979vKk
mHJbH7uDXQzeDpf0npqXSZCD/U0pFjYoTTSw8K8U+avYyMnwJEW/G6RXVnnFMWjOAmKeYmXV
tqam/KhSvLMLK7KqZNbbLiCM3HXptLp/YKICbS0dPNTU1bUgaDaVoUtssDCS8cd2iFHHNJW+
9qcNEG058WcvEKaMb0v8VVdEqLoj4Q2pvM+9Hlu+Opy2xsHVP583bg0SXEtuXJPGkfbccqoi
oTpUKwcec2e4C/57K/5m7Tf95MYGOGaioao5TnQ9LpYTCZO4qHLo2Nzg9oNawPn9xLVpDWAS
+7Mr7nptsFTdqcqB64sMmazulXPhJvSt4Odg3rlLYC0WmmwD3dmuuiIaLAstZbr0qNYMjRP4
CAnJc+wKI1Ek0XMzbUBWbNYGzeYB2I/N+uW0+vy0Mc3MI1N7PllPMeFZnGo0bRYjJLHbVYG/
jFfXFhTQFNb9UtbbV7QUlTzXg+GUK+qSrP3E9vVCmzUnSTff9oefo3S1W33dfPPGJnWOxLoM
GICLixi2IJTpIJaIidLltMh71z1nLDdNC+5rGliVf2n6S2dCozZ9DQciFrFwypcJWNlcG4Yw
pcPr7l7ADtN+F5DxWCVDNumVwRuh4VPZS3AZ1wss6KRwe0dU6pnfvKvxUlKeGfa6vb748K7B
yBjIXc5MqbOcO/kOCl5uRglIpletxeApaozk/KmvQFPyQy6EX00+TAq/jn4wtkb4ytlN0FXV
+eoY0tEsUdOLgN7XPNRICReA5x+0SVZ+RZFX3eK7zebxODrtR3+vvm9GlRcSK2Bz5O1Hj4+R
a1Z5t8RxL8I8372KJWhqPsEsG8uauM/sKtuc/t0f/gGXZCgxwGpzpl1Ow5Ey4sTHZkXGLbcP
f4G0O7xgxvqzuzpF4rP7d7G0hBZ/gZ81Fb2hut+sq8/goComZS4STv123eBUsuHnzYoIvCZX
mtNAsyVDp9XX38id6+d51RhHQas4rJV3eS0pwEmSPlJ5mWe5Qwx+l9GMDgexWzHvrYDjkki/
jOEJeM7PAaeo4Vla3Hlx8Ghm674K0z34qULMOXP0TEV2oXlw0Vj4e1jwVksyC8OY8p+EV2sG
ol4DRc607TMMaZo3wy6lIsrDnGwwJFm+goFQuFeMlv0ciqvDX6fnPLYWhxYTO/ptlHYDv32z
fvm8Xb9xqafRjQr1POeLd4HqF8wMPRx+rIPZhZRIf7m2wYEYzoSSIF9pHtKogFzlLvwucX4G
CFwZ0cA+sT5AtR8mA0VoDbzjBYBb4R1PxoEVJpJH08CXDcgVym/zFgkEtO8vxpf+DseIUZjt
30lCx4Gtk8T/Sndjfy0ZHMxAAX8mQstzxhju++Y6eGbjuPuPRQOhG1w7MaGMFyxyli3Ukmvq
VxULhZ+wBL5mgB2Baz4PSy/E3GFrkCn/kjPlZ1RzfrNTCDKDGMkVuKgKi3ghrE9ShxfIqPuF
hgWSd+gF3pduo/PkU9LzEUanzfHUq2bj/HyuwYHyRlyDmT2A7XZYF0VSSSIuvIehJPPzg5/3
SAznkyHJjbG72HMtS47JWeWYLBpPkYmd1ozqKhpA69h93jTenKlApYQaBCvErUfQuShN/yFW
SqvyjaWJ4jkPtGDjvX8IuMyEx34Ay2dlKBOSxf4ryhXBBFPYN4j9sGSpiyzzVnymUsBenNZ2
IwIQNaJ/7Fx6THiCca2HDNMzDUFAI6y94I1hE/tH0w1Zlwa/b9fgbZsmB8vHrRvwrBxF/0f9
uZ1yB7svFrqrotzEYCBMviIwQInKU4eMGfH1VLcwUw1WJPCFl4uGuYJfQu6+UAkiQtDht2p4
+NSrSxCClYx5r4Oen6l3m6vUgW50BHLhV3YIy6XffTQworjfoJjTwRuVwKCmYht4LIMTeBoD
w/rO+RV+6aIrRCbH+B+/4ajyCIg+zPfB2Hq/Ox32T/il2GPL385txBr+exnqzQIE/FDX13pV
y85x+3W3xEo5Lkf38BdlNcTXOv0cWpWk2X+G3W2fELwJkjmDVR1r9bjB7yMMuDv60dujjxdM
ScTgBcoc8z140OAtfPxrfMk8KE2n1KsrtzlR/6u0L8Z2j8/77a6/V2zoNq063uWdiS2p47/b
0/rvX+ABtay9DN1vQ7Loh6lZduQuKXs6zlqIEhn4DJDkvGfUux6D7bpWzSMxbBcrqm9dZizJ
AxICLpFO89ind8HCZhFJnOJjLiuKMZfpksiqpSBqTEW8PXz7F7n4aQ8PfrB3Ei/LRGBe03uB
/YltIidJxNJUEJy8Zrt307As+SJ4OIPAFjLQp1ohoO2syZRVSvFMpssUXQstTDPDsPsAwYsi
gR9kwhOum+jdrv4Mn6xtNHo0xtZ5Q2Xa47D5KcQ66YwPYVaTUEPUYkQBHgYNfRc0zZSPH1Ld
PnRXuXheHY49kQG8ksi/TM0jsGHAsIo+OrAamJgKbD86jgMrmC9LPSsMSivNBs0OC/grqEms
Y1Tfh+nDand8qvqaktVPt5oCK02SObCP/SmhGezV02Id8DVDAB6EyDgKklMqjvy+pkqDk8w9
isD3zggMZpAR2NatWFQHUQMtJEn6pxTpn/HT6gj67+/ts6VH7QePef8dPzIIvY0gBRgAO2Z7
glaTMl8s1N1sQ2Am6g4nl+UAMgGVdY9Z4XOnRsQkgNhDmzKRMi3v3T1gtn9CIA5e8kjPysuz
0PFZ6HX/FD24v9/ct4lASmqI6f0orzkwvxxeNx97xgYbN6Ph7Qp97p6xzpzg/9/HQ5SkkdJ+
09mggC0jZ6gXmicDJUP8bryBBb7TNKpvoljADzkjKpWbt3p+xsC+HjQhsMFarfH7tr6SrTsY
8PkwDRgWcWz6SM/wu7nccoGfbwW69pEIOIGDO2k8z1c2Xv0/GzZPX96if7Ta7iC+B5q1ZfL5
XWbFlN7c+D/oMIorOfdE+ewcFP49BzYafpy6TFV59NvjP2/F7i3F0w1CY4dIJOj0yntdr99E
lT0C/6tPFDQxDoc5kyzLPkJVsaYUlv8KC/rcfZyK00pAQ393RtI0lFnu4076icKm7OxZsc1i
4dHMBpI8iuTof6o/x+BKp6NvVXkuwBXVBN+Cr5NyKRUTfxSMsNk9eMz+fESkrVqBiG29AQ5L
kXEd+F9bARQr59rpn4TBqnjqBc3F5KMzULcnOGNO6wP8dqpnArv3FJMLtOAs7e226nzw1eAA
iI3wTS2EihmToNf63Xf4XWj7LSZ4C/UHpF1YUw15Fqh7g3x9SVmRJPjDn66skeJwQxGCMYBV
CiWd51fjO19TXIOagH/kdto0o6Zkb9onb98PlzCtRALxzu4kkpPzW81egau792d2D3psuHns
Z6z2ffnOBzMJU9OG0MUEEZgmTEnTaOHfD36tggyDCcSzG37twFK571Fpu0XKnKxG/5YQ7vWy
AVD2k7CNnrGJVjZ2e1z7wiwILtN7FKVAjeb/OXuy5bZxZX9FNU9nqjJnrM2WH+4DRIISYm4i
KInKC0tjK4lqHNsly3Um5+svGiAlgOwmc+9UTRKhGwuxNLobvbA4Jy79XASRlk9RKI+9MJFr
JSrDIRRUaKFlWooQ19tL6qbyt2WhXYhIv1lbM9IKuHfBKiAIRFFKPyDcrLxR8wybK4WnwAgh
14mBlPdjr7jF7wa3qtXV/G5405pNEwvt8M/+fSBe3s+njx86wsf79/1J3Z9nEOKgncEzXDZP
aoWPb/BPWzn2/6htnGqez4fTfhCkCzb4Wqspnl7/8wKqisEPLUsO/gWeh8eTEirFyPvdmQlv
ia8qmG2VLPQg7pFH3EOAoiTcgsRYMsW2s5IR2txNCo72OMdmHwNHpS98xwVF/WythIQnsYpj
abmAAxCMUe1GMiZ8CBrYjCtnVcEZJaQjhx7h84ZTH+MiR5/UYC0xu1B4gx0Mx/eTwb8CtcRb
9f/v2J4PRMbh9QtvuwKCZLpDP7WzG+vbmKfOcgJejVphhTEo6v5XBBNIjftO1PQumiexTzF5
mhyiEPiMxZrSVfKVdooiFHLaLoRTjDfz4KEeV5ikJGhTUBDQyREvOnOW8bWP39sLwvhAjU8S
BFJ9l/qXTIjnvnyND1CVlxu9Mjq4JlF7Q123cRgleMOKN2uYFNTLA446Dn8I3W/UHaHo0FgJ
lPb+2Ciiz3HDpXyXLhPUDdRqj/kszbnjz1gVaW+9oHFYkAYW3N2xPB+OhxgrZ1cKmQeGwW58
UhkKL0HVmk7VnLsGoszjLQpag8B+hpW57PuIiH2x7UcdkEMl1c/ZcDgk2asUFhVVzthtqgMY
54I5Da8In127XubhY4QdkzgqWJaHlFFMiIvrAMA3N0Co+e1Z6HmWML+xZecT3FJm7kVADQgH
grjAv8ej1j4XiyTGQ1RAY/iZkTuZ86jJSdkVsRPrfjC8yDnfG2NqLatO9YSHLq3HNmId4aAl
D6WOtnedDFNU5vgSX8D4tFzA+PpcwRvsVdkemWKKnHE1DyhSRZt3OydiwZVkJy7kEL8CcRJq
Ney7xE3fbutQoLGsrFqV0cW1o3CEi7pyHfvNJ/B2exBNgTseYXM+6h07/+It3XDWpqSMUwhL
FSvaGxmvp76WwDUCTDqcjQmO60HEMKKj3dxXiktz9xcUFwt1yWoIUm8hWBywrFkHBuiVgme4
KcQVhWjW+pJFkixC/Kws12zLBQoSs9G0KHAQKFadOaZMCXgz6IYLIcIUL/BvVuUb3JJJFFQV
BSA6mZC995y7SABfkwSOQuhz1LOdI5ZteCNoyOZ2Mi4K8mKMNs21vR6hB8JeVD7sem7SSI2C
xYlzsqKwmJRNk70rbEpLFwoqt53gYNs/ne5uepCz2XSo6uJPfw/yy2w2aUmPxEI1yYH69js1
67+yxIqYots/2mXum5/6PbwhFiTgLIx7uotZXnV2JbqmCGeQ5Ww8G2GxbOw2eQ5x1B22T46I
7bQpFj3bV/0zS+IkwslI7I5dKIrH/2/Udja+v3EvndFD/wrHG+G7PKEJe984Ue2KyYMzYoWP
+gFZNSpPFx4vROy6LiwVK6x2GTqxOw6mHoHo4VJTHkvwFEcndxUmCzcY1Spkim7g7NgqJNk7
1WbB45ICr1BvAnsga1DsRA5nulIF6qpmRCCjqHfhM9/5tOz2ZtKzszMOMorDasyG43vCsh9A
eYJv+2w2vL3v60ytNpPowmRgMZ6hIMkixeU4TiISrqImrUdqcjuQhg1IQiVcqv8dhkQSZrqq
vAxguXp2nhQhc2mEdz+6GQ/7ajknQP28J655BRre9yyojKSzB3gqPIqhANz74ZAQRQA46aOM
MvHA8qPAtQUy18Tf+bw8Av6tf+nWsUsX0nQXccJ7G7YHEfHMY1IqNh4/wwKL1WsPYhcnqZLJ
HE5865VFuGic0nbdnC/XuUMYTUlPLbeGKL1UsQTgzSM5/u15iHLQVpsbl6qrn2W2VIQXv70U
dAPBthr++u1mt+JL7DowmpJyO6U23AVhjEaPsxo37w1249ULBJDHUFAuhQaHFYImoxVOGKr1
oHAC3yeU6SJNUevs5S4U8+sZkFtVcv0ZCIiJaIrMC5MQA/Wzw7iBRboCrvbwRUwDK+UOjVDM
Znf3t/MmQgWuVSbVcG31yHQynNyQ7SqEO3WRdsFnk9ls2Ilw127gCjUOMfVUX4+48JhPf28l
2pNwn21E9b24DOOl4VqS4LDI6araaKbYsh1dXYKKYXgzHHokTiXu9MIV39yLM5sVI/Ufjacl
iE6wFgN+ASOnl/oiE5AYJoYgo0cSF2npTaZl/pmpK4zedoDXh7PqHErFI3XANVtDwxVr0zll
cNXSwFxJ9wXOj4F2WZ0J4dGd+ynIN/R6Azz3ZkN6rXQLk1k3/PauB35PwjeKmkvJSXhFsBeK
Zo4y+BMhDiDbl+ZByzIzhEITgqEqSYJapdSol7lSiKkp8jmj7Js0gqJIEJmUuEQ0zlKo8x2Q
F43GUavvqRMhiCcvQBHpanIzdNhrc4+ATiP6eD4f354P/zQtoarvh5C8xj0eTAGpoLsOcgRh
Ghat7lJPdlxZCloWadOT/+L/0Kpq1UyJDEgNRanubfn6fv7j/fh0GKzlvH7+1FiHw1PlFAiQ
2j2SPe3fzodT+xV6G9rh/eHX9VUqMkIRBsudRyOIVUt7YCnolBK93UYjOzKfDbKeMBBorepG
QLVikQBl0rVnBcccwv4zzYSMXP9ipNGrUg4Dcl8wck5t5RICzpjrg+jALgIsBpQCB8gcL88J
/C8735ZbbZBmt3jsvh1siefmLQXYRAU83FGqBtRV88pmSB9vNd5EreMjXt4+zqRlhojTtRtB
AwrKIADDQHDaJfgcQDK5EB8oK2KDFLE8E0UT6eJ58QxZ7I6Qj+frvmF9VdVP1pJTTtoG5XOy
60bgmz544zxbE0fb85q6D3w3TyjLB+sTuscPEVHw9x6DoqNsEvEADEKy9pZSsXKEIroaiaIe
hK5JTHALq+X+9KTtm8SfyQD2juuIBGpShE4ghqAa1XlvYxFvv3xW1wfW7cUsBtvRZlTf96f9
IxD/qzVfzTrljnSzwTRrEFDnXjE++c46+xDz29uRhZVJ5Wh6sakMfW3GtQYzUHZxj5KH03H/
3HaDgWlRXK+29/Vsm4AKMBvZSUusQitRYNvpxcbTeU+UkM9UUSMhl40WwCXxgMyKjeQZixa8
I8fX2wbwgmU4JM7KtfbmmmDQDGKURrwLRcdg8rlPfVXEYojFgPuT2YhyybJrXld0uiEcK2kN
6oxbYi/wzmTLkOxn299+PlJiXRcaeMmFLAd/6daJjl9f/oBmVInekpqdQozXqqZg8psKGBfD
DWBnFVrbpdnqZ0lkNTNgKQIqD2uN4XkxISVVGJUxzuecgWkaTjxd1D60SjJJZS+mon9d4CzF
jUsqsI7wnvb1obFEHCgevw/VA5UtxHL1xUJ4ii7hzhINGtVqJlbLqR2AietOZznTeUOWG+0p
5y0J9icuF8QGiJMvCfV0By4AORFWdLkxaZ66pkHHLyUcZlW7VU4qQmjNFImtNzR+xaaRKE2m
TSLywLYrnx9LU7BHwyMGbpxYizo2sWtLu0V8nq+1mx4Yuaf+T/FxqE0e7ijX4fYFaw8Cvq3M
s7XMddy0tnO34atGHkZuoBjr0ka3sMfEAUvxvSNTYlMtm2bGl73cDjqY5ung8fn18W80OkKe
lsPpbGbyebfqch3CZmC0mTp3Mxm66/yqqh0G5++Hwf7pSbssq1OpO37/t22/3h6PNRwRe3mG
PyEsUpFQoWu2uCmXCYkCXkNEwIc6ZEoaYsrc5TZyX9N1QeVrD4Jg+5banxUVwtQOkqszmMmS
yfEd8c5VYxRCCVLgrQNhmomnpEtrKafSZ1Yo6kqTTEBUzowwLGkgphKPulfjielDySIieWiF
E7FieH/XjZLdTUc3uCxZ48S5V4Jhm5IAKBf/C2qqFfudOFLI6fQeD2pW42wEu53d4ub4F5x8
NhoT+blgtMT735ZBfK8EC5sp5dxOoXftUWK5WOdexFD0eSNWqtG+geLt68fLo44N0OGoGvhG
w1PC5exRjsEXrGXoEU78gBMBFSW8GhR4KW4no2Gp6BuRoSf3dPweD98gISSnIcK6AUwSMOja
PHekEU4SAOMzi7+UXpRQpliA88CjNCS8V+Hz89sxcQAAnPneeEQ8aQNcRtMbwl8YoDvpEfby
AM7BkXw8nhZlLj3WsUb5KipmhDO9Am+KWTObXO1z07WlrLuVLyA9FnFyM6/DiAwUcaUH9vUm
9nUHFoJhgsqc9m/fj49oUCC2wExbNwumeGDrgbQq0JHZFjqBq+Vm6CNSClNltktenXvHKjbx
ZU77H4fBXx9fvyqmxG/78AVzdN7Raibkyv7x7+fjt+9n8Br2/Lbm7Ho8PF9d9kzK6iUCnVlI
FxFqRQiNWsdl6en5EjCmuRwWlUvWiJ/3UvhtzZ8qdC5k4UMUSCUH7SB7BI8XhGGlQlTsJgpa
LwWaElz4dSycizbk7fAIogZUQAgo1GATkB+oIZTMy4gAuhqaUmH2NHSdUZYlehp4+CBwogBg
T11MGSGEaLDi4uMOeLJeMEJAEEDtIRJeR3V9VGnwLs0orS3A1dotkjgThEISUHgkywA3Fdbg
kFM3mgZ/acRvdqALHs0FIT1qeJDRTS+U3CoSQn4DhI3YsJC05ICbZqf1pDTCjp6WLQtzwqvb
9M23MqHMA/Xwd1krL5iDAGYNdP+UDQzAPrM5wSEANN+KmBLEzbTEUskdecfQQk8z+DScx8kG
v+LNpl4Ij1aDG5QQjGQ74LtAEVB67TJu9jbdQm16TmMk8E7WsX31o2r3FoqJKNwAA985XL0A
0JTFwPOqTU6fj5TnLNzFNOFLQb3jdTQQMpCFYioAe4Wz03HaOyYzzYS6ykmwEn+6PrWy8KTh
IIvBGyCNQbqMVlAegtKH8qwHnHUMdj70fqIUBnCU4Z1F8dT0mZMRy/LPya6zi1x0nBlFbCQl
kQJ8DdewEjFxth4wChFHdPtfeJZ0jg7eQL2uI2mEuHJJBBzVN23YjDJWqxoxBuDy+GPxK5e3
GSXXJUtPlKHI8xCy9qhr0FEpAEYnjxsR/Lu68Mjnt5hvFXEjgpibhH5CB/WjDMICEYt5I/hO
BeRqfutENFKxMxa7rEHVx1xLMyXKOWaHUKDZSrdo6eWJ3OGFtdXMb6fz481vNgL4IqoZdmtV
hY1aV8kj99rWEBYsrhSXJipc7rlPvRaiEiUD6CxojFqXp1niIcWNSDF2ebkWXDvB4fISjDrb
tKJfXNSTMNIrW2o41lRQxaDMI2pdcjm7sNZI1OWIb7EawZfDESFgWijTIS7q2ihTnGBYKLez
aRmwSBBcqIV5N8HfMa4oo8kN7t1Zo8j8YXiXMzwGXI0UTWZ5z9cDyhhXSNko0/tuFBndjno+
ar6azG66UbJ06hFahxplM74Z4drLGuPLLl5FbcXo68sfkHbc3VCNqldpq73TjPNvZ89Brv51
M+weXnY3vmmHbwfSLQ8v76+nvi2/SEI/EARD54PSa9OMjGOirUVsvg6wROiQpBqSc+IfZ+qV
EMq1jBNI9tqFRpt4VQhLzoirrTFA67pYF76QaSO21vX+ovzLAgoAWafokB/Vk1XE47XrDqCL
qfAxda2I6tRPscftjY553epLl1LO1AZq4lyY67yyq2iteXR8PL2+v349D5Y/3w6nPzaDbx+H
97OjlLkEselGvXavmLj2O1cFUxIuJwRJxRkvqAgpnXsavL+SWN3XBFe7haR56NuRp9945OvH
idA3X420RX47wTVeaCNWG0yE8wTztRQJ5PO9MiNOnGkNHKT7bweTTA4JQd6HaniDw4/X8+Ht
9PqI0gweJTmEh8KfCJHKptG3H+/f0PbSSNZbHW/RqWktPujXmhF9DCOgxvYv+fP9fPgxSF4G
EAvy98E7cLlfL7GdL2wB+/H8+k0Vy1eXRNZKTgRsdJOn1/3T4+sPqiIKN89pRfpncDoc3h/3
aupXryexajVSfeNqLTyv8tVEJ6evLd3Y8d9RQQ2zBbNfSMPj+WCg84/j8xMY8taziAwWLFMK
8EqrH/laj+91dLFfbl03v/rYP6uJJGcahdv7xCvzdn6BAtLV/kO1iUEv8tIvba/rAHQijE2Q
cdxaiRcQnIgShxJCvSmIOyHOcQkQgvCRse23iKlqtjIhYttmqtmq6YsOFjCCMBlotmN9Argi
k4PS79vETjL8/HKn6NZf73oh7H1Yx3rv8HUqH5KYgZRKO2eAKUCdYMH/FSTJQkKFAFhgISSi
YhatoFsSLRIFD9WfqejuNC1YOZrFEdhMEPltbCz4UnR53Em0aoOK0aNiEhOZqzKGL6XqfdJa
PvbydHo9PjnvV7GfJc3kJjUdrtAt5o+h0Qia5jmQArUWZq+nRBdnEW9v/OUWQg4+QrhkzBCP
SB5jnl+bzzS1DqXd5LWmjlyINRkQ1jBSJIRBQCgi6jRprwPPpBUgOKJ13Eo4d8l/4thdm7c+
yFRrto1zCWxYKHyWczX8roTRiuiNygAfq4KNO2ATCpZxobpT/RLwzzSooEGLQJIjnecd3cUi
7KgajOiaCoJvbl4A3+du5brMBMUuG6kE6hYhiTvARWzlgYzAfjCHZL0NuD0SPCW3jaFkHtxh
OZBGuLv26DcLhCloZTkNWIdcuFonRGhJsPQOJLlDDJicdjUIClYFYm6AzcbfP35337kht6Ps
1H8GEskbfEnGo9szDfp/QEB6iPgLBw45b0Im97e3N9S4137QAtX94G0bwT6RfwYs/5MX8Gec
U72bpOpE3xtVlz7HHcA4RxappkVdIzN8wfvh4+lVp9K+jri+1pTYUtp6TV3w4FpN6zKwRsnD
RqFOlKwER6EOjb1bNVAxRaGfcSwgwAPPYrvXhnJVZ/hxbEKhAGyhRFEyj4g9oHEKiNqK9Khu
tsBX8jxXpNjx19Z/0dOLTN6lSXClAEJhAuU5A04yFi84fbSY3wELaNiyE6R9wynS3DGaOQ3q
qPU56CDnXsYiAiRXayaX1BnpuHkgBF5BEqSoY2pSGraKi0kn9JaGZl2dpmDMSLgJ7OSGJFAd
a5G1ifWVwmp7XXc71kBdy/29GTV+jx12UJeQR02DiRSvQOjxFDQZpECKmwPxhQT/MZ1l+arH
sdvDnqcWGYM8b+C25VueT+rCbv5UA3U7NKoui/as4yx11NGmpEPNqvNrUhtfUIDEZ/SRp7km
Iv/sOhaqRczzRSTl1ngKXbKVWaxp5fD1+HE6nn9imuoHviPOLffWwNiUfsSllkdzJVVSvh0G
txOI7mTtkrdkmZIhua/ZIC9Jdzqzmsca10wLDectIOaGYqlkss6IxwVtUeDpZiI1qe38czW7
VmWXuE4Fsx7/Qhn9z2/gNArazE/wB8Rd//Rz/2P/CaKvvx1fPr3vvx5Ug8enT/Da+A0W4dNf
b19/M+vycDi9HJ4H3/enp8OLnTK30s1FJj3I8eV4Pu6fj//VicBsh1mRw7cotjc2afCuXLun
butwvRAxWNCt1VXO2YP+YJzJR9Hnu4zjxlcd+LB0hAimRpvEZmkvU0uw1TUyBO8kcWs1Oz5L
NZie5KuvUeN41BNsMmjUembv9PPt/Dp4hMSVr6fB98Pzm04i6CCrz1uw1HI+dIpHrXL54Il0
aUcfawDaVSCtMFrYRs3ixchhf0yxieiHb4UKpblV0AYu1LyV3rfCAzeprl70X7hdST1v63yp
RLAuFPTpPP346/n4+Mffh5+DR71u38BS9adN+eo5IrKyV2CfeEExUO71wrub517WgyEjIvpz
NYXrbMNH0ykSoYN9nL8fXs7Hx/358DTgL3oiwLb7P8fz9wF7f399PGqQvz/vkZnxPCKumQEv
usHeUol4bHSTJuFuOL7B38PrVeYLAVYFnfPAVwL3nL9M5ZIpurFpzcNcPzf9eH1yxdR6nPPO
3eU1rbYbYCI1+wVM8cvVkDsbDzPcuLkCJ91DS3u+rOgem2IMthmhAa2XDR5K83XnNgCrpPaS
LCHDHLkiVMiamtb1wIueD9806huR//jt8H7GRpN546Y/IILROaBiSZmLVhjzkD3wUedyGpTO
JVMDyYc3PpUmvjq2fWP5lQMb+USg9BrcU3sKDrqdKEKdZv0U0ImWRf7wFjcOqcnGkhER4a/w
vsHUOGAM2oM3muK2QQ7GL7Y1HXbuKoVBBLOvL45uMGRzmyeEyGNwtmljDOZ8HN++N94+L3S8
c38qcEnYJFsYvzA5cx2Mt3sbewwiZBN2sRccmXfuVEDoXFC/+4sD/ff/VnZky23bwF/xYzuT
ZprETdIHP4AkKDHmIfMQZb1gHEfjehwfI8ttP7+7Cx4AiYXUh8zE2CUELIC9sNg9RUz6RV+5
mhXtnC6290DWbTGll16+58eX/e71VdsV88lh1T/vSqRb951fB/7KBLANX3tHDeCl92BuK0cN
zBJMsufHs/zt8ftur0M+esNptt3yCtOclkwMTU+GMlhQPJEP6RvWVcQShCVnmBqatQJbQB3j
wwNibwqchHxkLgOekGJOus7E+Xn/fX8DJtX++e1w/+SU0WkSnCKREE3v8KNYTj12jtdLJ0yw
tZUXH5ydnSLCxqG5ddSJztE6zBuM7l0mca6+/PmH+07SQMQb8FAwLwUMvFqkSc2E4BpolYjl
JmQS8xp4ISZiOoYkMspNrhabdL4ndvsDRnaApaAr577e3z3dHN7ACr79a3f7ACa1GTlyCjrh
p55NhpERk8C2DhIkILYwytBR3B4kWh6urlWMxf26GzUHSipzBorZzrDWsm3KFmXEKCH48kSC
kZsF7rDHIRIjTDB0zS75HeJT2RC4BrM4IVMRG7/zanmhSupGuZJKkaI6GcOnj5jeOWZqwnYI
aRLK4Pqr41MN4bg4oYiy5YUIYsCactDPbM8swP0+G067V5EPXTVMtd5uZzfBxCJ+mm2Rs2Ay
HH331A9gi0cNa2LbBXJBxjnbUbQ5AZttV9jH+lttvn6etVEUy2qOm4jP57NGUWautnoJ23sG
wHx7836D8JtJrK6VIdM4N7XYmukXDUAAgI9OSLrNhBOw2TL4BdN+7mxH8o8A2AZ4gM3IGt2E
9xdKH2yjPTLHlksZqYqCtfFt4qI2nHeUm677QmG8VyYqI5+krnAcYq0As8LxQGCEoyznnr1E
V8YNbk4FnOdMT7/6oQ0xul/LK5ShqaNP2NxxVJvzXcuhr3VUFfNfWMgak8oUcSSu51D8hpLO
KDNr3ECZFUYqWR7VAQSQUgLxqdK8qBUIzkXuwGv04ygVp021pMCDCRL50FuRGqSvgClNGDbe
f+QL58kfa3xPhZrt5++lJbW+7O+fDg/0ZOfH4+71znU7o9NAEXk4CYRwfKft9tfqJFEqxcpR
a5n2vvSLLyzGVZPIesxwlwHl8Np/1sO5sQ+vc4EvxzwvFUyMWYaInsDXWVCAQFGyLAFdmgcT
P4N/IPmDopLmdRdLxsHAuf+5++1w/9gpIK+Eeqvb9y6i618DDu5KJxmXMDLVijK/+PD7x3N7
e6yUqDDcLuMitERE/nLBZBxbSkywAowFk5s5j58eWyVDjEjCmIQM88+YKe9sCI1UFXlqpZzU
vVCNHRU3uf6Ejo/6xHih1lma5JifmXEJml22eBu0kpieqHEek5NXxQrw745RtPv+dneHNzlG
uWQrKgefeOOtO5MfsRsqex1JPOFyEVmZ/vFvxwcjkwkqkYOykyc12CV4y2U9CEWokxQnTc5e
fQynMdMr61aMT+mvqrorsaEzW7eG00y5Kqf1hCcEQkS6rHNzHuymaHPGLCXwqkgwDwFXw5d+
pQi+Sc5L3m32VLgoT0vVEYQSBIvL+RbvIb7u6QK1QSbnxKpAXkQdlswp50boyk06ynLqdp2p
1YJy5c5HtWYKpk8+POFHkrJuROr4BQ3w/IyOraeLVj9xaeYY/xenRTv/JQvsP1GiMpOeTwDo
lcfNZtxhhjRTDR2fEdpQDINBqZwX49GLok5jHg+vqJyVaowxxF0d0vGbeP440b5xHo/XjCjL
SW5WfcWA+GfF88vru7P0+fbh7UVzveXN093E/M2BgQFLLtzhrBYcQ44befG7sWOLuMZgmGbV
ZYplcjV1aWSXTY7Vxyv3IWmvnCnOjOBo36R0+AlweKxDv7cYknW8iGyWsoXNGKfBvNl3dDld
BFSaLqVcTfiPdj7gjeDIa395fbl/oqSG784e3w67f3fwn93h9v3797+OQ6UAY+p7QYrgPHxp
VeKTzi6Q2G2HYh84L8/RRJOiqeWGcS13W8zxQm96xI920rYaCXhs0YIKzbyA1aNqK8noNRqB
psYLDI3U5xhIYWGO9IU0Jvdnp3C7f5t+FXZ43ZRyZmqOu3iYqFN7HzZd7OmqV/H/x9aZ6ZTl
VZyKBRNwhZy0xkg39xRQkQPyqibHZBxwaDwZXDvpp4Urw4getMbx4+Zwc4aqxi066RyKcJow
5OrUhCPwyif9Kco9mXjPBhzSD3IViVqgzVA2jjh8iw0xU5r+algC/bBQlR1sp28PwsatNwFA
UR1hfpchytGtiEgYJ3VKX+xmQKi8qlwWV/9s1JrH7OBfdap66VDSbaOLDhjoi+godg8VHV15
eD1JSWWK2MHGoBmVEyVggC5KsVq6cXoDMibotANqVBk94gHiost2goLx7Hh4CBP0Up193sQI
uw91L0Z0Onxhs/veEuyHMhBiMk3+lPsQgEeAAI+9fZDM9CAsW1gTH4LMyQ7tI+s0JvMsRBO3
IyCTsZq+V1UuVtWycCmUATArULNAQNJbm2m8Yt8ucuAIVEdAf8BIrwEdVtSLGKSXdMGBtdvZ
w1Rd5/VSyTWwBC4FUYU0ShYLjkjjtlIBnIVlJkqmZrrIVql0KXWGak+v85KKhGkrja2sQ3DH
JNzjpils2IytvTz/s9u/3DImIYY/d6F8rSzLwuVKQiQNNF+F4Iz1lo7kql5efDY8IhiwDLoq
KI+832zcZFipEDRWL1pWJUo75vx4OFb0YaImTD5Vj2tqkzFWcBCB7tEmNZNhjTLMY6kMDxOe
U930B9a71wOqEKguh89/7/Y3dzsrNLvJmZuRXmwqWg8w4r5pt4+btnTEnTjTrXcZFuuZiQWm
EzTrLa7s0HnEd/TXF8vA9cGln+biwHZSK2CBmBdihJIlOSU34TH830fJmrlACnpVi/aRRwoH
GCXjgZNzv0gLTKfBYtHrUzDTlL+z3hPv39s0s6XcRE3mI4x2VuvQdoZndXhVyAQsEMIlYNTM
i1tCIB7gvoskuD6vPLxppk+eTehGlCWTpIbgLs+DjVHiHd7MnzIhJxeKQdAkYl4oJ3mE0zvC
8jWd6T2dhwqR5JLx6KMgsxBEunfF6dKc4Rh9J34ECrdH1x0roPCNKHSD2OaJ7pqcTNDL7WZR
+vqK5D9IPwhjn+EAAA==

--YZ5djTAD1cGYuMQK--
