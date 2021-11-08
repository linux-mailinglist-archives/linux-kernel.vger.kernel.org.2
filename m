Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CA4447F7E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbhKHMh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:37:57 -0500
Received: from www62.your-server.de ([213.133.104.62]:49926 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbhKHMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:37:56 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mk3rW-0004Gr-Qi; Mon, 08 Nov 2021 13:34:58 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mk3rW-000MVN-KI; Mon, 08 Nov 2021 13:34:58 +0100
Subject: Re: [dborkman-bpf:pr/bpf-tstamp 3/3]
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:2482:44: warning: shift
 count >= width of type
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f98d886c-dc50-9c8b-c160-6e8ecd895cb0@wanadoo.fr>
 <7658171d-e551-cc94-b6b6-0c8bd13d00eb@wanadoo.fr>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2091d820-e95d-f3e1-722b-3b24f028f571@iogearbox.net>
Date:   Mon, 8 Nov 2021 13:34:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <7658171d-e551-cc94-b6b6-0c8bd13d00eb@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26347/Mon Nov  8 10:19:39 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/21 10:12 PM, Christophe JAILLET wrote:
> (resend because of HTML issue reported by mailing list daemon)
> Le 06/11/2021 à 19:42, Andy Shevchenko a écrit :
>> +Cc Christophe (can you look into this? It seems your code is involved)
>> On Sat, Nov 6, 2021 at 3:52 AM kernel test robot<lkp@intel.com>  wrote:
>>> tree:https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git  pr/bpf-tstamp
>>> head:   f7d619a946e981177777983af26e9e31163ffb38
>>> commit: f7d619a946e981177777983af26e9e31163ffb38 [3/3] net: skb clock bases
>>> config: i386-randconfig-a005-20210928 (attached as .config)
>>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project  dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
>>> reproduce (this is a W=1 build):
>>>          wgethttps://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross  -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          #https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git/commit/?id=f7d619a946e981177777983af26e9e31163ffb38
>>>          git remote add dborkman-bpfhttps://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git
>>>          git fetch --no-tags dborkman-bpf pr/bpf-tstamp
>>>          git checkout f7d619a946e981177777983af26e9e31163ffb38
>>>          # save the attached .config to linux build tree
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot<lkp@intel.com>
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>     In file included from drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:9:
>>>     In file included from drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h:22:
>>>     include/net/tcp.h:812:27: error: no member named 'skb_mstamp_ns' in 'struct sk_buff'
>>>             return tcp_ns_to_ts(skb->skb_mstamp_ns);
>>>                                 ~~~  ^
>>>     include/net/tcp.h:818:22: error: no member named 'skb_mstamp_ns' in 'struct sk_buff'
>>>             return div_u64(skb->skb_mstamp_ns, NSEC_PER_USEC);
>>>                            ~~~  ^
>>>     include/net/tcp.h:2367:8: error: no member named 'skb_mstamp_ns' in 'struct sk_buff'
>>>                     skb->skb_mstamp_ns += (u64)tp->tcp_tx_delay * NSEC_PER_USEC;
>>>                     ~~~  ^

Please ignore these, it is just a local test branch from a private tree.

Thanks,
Daniel
