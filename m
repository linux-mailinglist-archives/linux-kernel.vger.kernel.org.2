Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F7A315FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 07:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhBJGxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 01:53:33 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:49902 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhBJGxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:53:12 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l9jLs-0000uS-0W; Wed, 10 Feb 2021 17:51:53 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Feb 2021 17:51:51 +1100
Date:   Wed, 10 Feb 2021 17:51:51 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andreas Westin <andreas.westin@stericsson.com>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Berne Hebark <berne.herbark@stericsson.com>,
        Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Declan Murphy <declan.murphy@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Harsh Jain <harsh@chelsio.com>,
        Henrique Cerri <mhcerri@br.ibm.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Jitendra Lulla <jlulla@chelsio.com>,
        Joakim Bech <joakim.xx.bech@stericsson.com>,
        Jonas Linde <jonas.linde@stericsson.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Kent Yoder <yoder1@us.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Manoj Malviya <manojmalviya@chelsio.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        M R Gowda <yeshaswi@chelsio.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Niklas Hernaeus <niklas.hernaeus@stericsson.com>,
        Paul Mackerras <paulus@samba.org>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        Rob Rice <rob.rice@broadcom.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Shujuan Chen <shujuan.chen@stericsson.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Zaibo Xu <xuzaibo@huawei.com>
Subject: Re: [PATCH 00/20] Rid W=1 warnings in Crypto
Message-ID: <20210210065151.GA15914@gondor.apana.org.au>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:09:40AM +0000, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> This is set 1 of 2 sets required to fully clean Crypto.
> 
> Lee Jones (20):
>   crypto: hisilicon: sec_drv: Supply missing description for
>     'sec_queue_empty()'s 'queue' param
>   crypto: bcm: util: Repair a couple of documentation formatting issues
>   crypto: chelsio: chcr_core: File headers are not good candidates for
>     kernel-doc
>   crypto: ux500: hash: hash_core: Fix worthy kernel-doc headers and
>     remove others
>   crypto: bcm: spu: Fix formatting and misspelling issues
>   crypto: keembay: ocs-hcu: Fix incorrectly named functions/structs
>   crypto: bcm: spu2: Fix a whole host of kernel-doc misdemeanours
>   crypto: ux500: cryp: Demote some conformant non-kernel headers fix
>     another
>   crypto: ux500: cryp_irq: File headers are not good kernel-doc
>     candidates
>   crypto: chelsio: chcr_algo: Fix a couple of kernel-doc issues caused
>     by doc-rot
>   crypto: ux500: cryp_core: Fix formatting issue and add description for
>     'session_id'
>   crypto: atmel-ecc: Struct headers need to start with keyword 'struct'
>   crypto: bcm: cipher: Provide description for 'req' and fix formatting
>     issues
>   crypto: caam: caampkc: Provide the name of the function
>   crypto: caam: caamalg_qi2: Supply a couple of 'fallback' related
>     descriptions
>   crypto: vmx: Source headers are not good kernel-doc candidates
>   crypto: nx: nx-aes-cbc: Headers comments should not be kernel-doc
>   crypto: nx: nx_debugfs: Header comments should not be kernel-doc
>   crypto: nx: Demote header comment and add description for 'nbytes'
>   crypto: cavium: nitrox_isr: Demote non-compliant kernel-doc headers

Thanks for doing this.  But please don't split the patches at the
file level.  Instead split them at the driver level.  For example,
all of your bcm changes should be one patch.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
