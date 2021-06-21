Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6883AE491
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFUIMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:12:47 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40163 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhFUIMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:12:45 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A85A35C013F;
        Mon, 21 Jun 2021 04:10:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 21 Jun 2021 04:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=19ZdQ4owmQhpDlLh25uzWmoDWN/
        ozfCkYvCkogqSzNA=; b=s2siAZ6npb2fCgGtGkpa52WBuw8JuWabPc8KQbibpB5
        wN3mAv3e1JNqEoMd779k4nnxIdpF0+xCBhvaC2IZyxD6ctA7eJD9oEz9GnQdxm+b
        t7V79DErU0eiRNy+HwCi5Lbx/YYFNeK9zMeoo6AgkJUcUjoo8iWbtV7b04zQ90oV
        fgHjsw7F/cZNfTZ42xAiP9PFesyEmBYZWkvccUVQF3mbLAS0Vde8ga7vTG3tqn7b
        2RsazCEtfhIPBvX5HeIo+NvwzPm+XUzjx0bYSAp9de8X0XoI1Bjpa+Q8SJVhczXs
        X7PoqlKHRlbIdQwIYbbE7MiqrjPoo0mqEPzltkImAOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=19ZdQ4
        owmQhpDlLh25uzWmoDWN/ozfCkYvCkogqSzNA=; b=k69Ks54OED7KsxoOGBRyau
        CRi04AXYS3bMstI6CBIjz5Z/XSl49og350qod4s2HktfRJLe49UEgQrEWbe58Plm
        U9DYvGX7jofAaPKyb+C1psoaymNFOdKwdZntGEWq8jHyERg1DWVQIXyiW694mWt6
        CKGtwPAiB+dUqJCmzfwch7JhRs2cV1l7AO9sKxnaD980wFEgK6ovnib9mYeuH0CG
        +vFrt+cxV9vG7GXRq4MohVhtiyp/lR5EL+2U7kUCbKI3RnF75mli368W8hM/bGbI
        70IUmA/GEqSS0eV0PGsOsLbGMbGiYXd4RagmOrJzx1yxw6fA+4FdMMcRl8lb4h7g
        ==
X-ME-Sender: <xms:d0nQYDbcR0UAWMpNrJsqCq0maxqyASwL60YOW_5eBDL3pVcppC7Adg>
    <xme:d0nQYCZjLy2US6UeppKgXWIja6L43_57Q79LnistNAO0KHGrwCxvhg9r9HQJ93PxB
    tTYMb3yG0vmeA>
X-ME-Received: <xmr:d0nQYF-zqSIBnCbZ-_18DzOLfML9OTmLY7xq6xLRRAmG5Lg97JRH7nU6xIkFFCKI071ZHvDrwRWlFUeEXekHBqvWgQdcyFSd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefledgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnheptedtfeefgeffueevfeefffetvdeuhfeivddvheejvdefte
    dvvdettefhieeigfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpghhithhhuhgs
    uhhsvghrtghonhhtvghnthdrtghomhdptddurdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:d0nQYJol4DuKOh7gWeFCcQkwb4rpBYbj7yFxPReIr2EsiaxLVg4JwA>
    <xmx:d0nQYOoidFLKCS-c6prU_zXlZ4ZSweTBC5ruTCee7zHwmGDHAdYxwg>
    <xmx:d0nQYPS1bw8rYzM8rEcbFJN2XVPKJuzSOpengVRRwQ1zmDMLpWe38w>
    <xmx:d0nQYHn0AmH8QHriuEp7OXB9IDdznhaz3ScIT2IgOqi05Nt53mbEUw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jun 2021 04:10:30 -0400 (EDT)
Date:   Mon, 21 Jun 2021 10:10:27 +0200
From:   Greg KH <greg@kroah.com>
To:     Jhih-Ming Huang <fbihjmeric@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [fbihjmeric@gmail.com: Re:
 drivers/staging/rtl8723bs/core/rtw_security.c:95:9: warning: variable 'crc'
 set but not used]
Message-ID: <YNBJc1Xlh75yz9DB@kroah.com>
References: <20210621063041.v4u35pxgglgwn2go@gmail.com>
 <YNA3KAxTeXsb35/W@kroah.com>
 <20210621065709.6ffzqujlt26evjjz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621065709.6ffzqujlt26evjjz@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 02:57:09PM +0800, Jhih-Ming Huang wrote:
> On Mon, Jun 21, 2021 at 08:52:24AM +0200, Greg KH wrote:
> > On Mon, Jun 21, 2021 at 02:30:41PM +0800, Jhih-Ming Huang wrote:
> > > On Sat, Jun 19, 2021 at 6:27 PM kernel test robot <lkp@intel.com> wrote:
> > > >
> > > > tree:   https://github.com/0day-ci/linux/commits/UPDATE-20210619-155350/Jhih-Ming-Huang/rtw_security-fix-cast-to-restricted-__le32/20210616-131056
> > > > head:   ed0359e3fa64928e48021387a694f211bc840ff7
> > > > commit: ed0359e3fa64928e48021387a694f211bc840ff7 rtw_security: fix cast to restricted __le32
> > > > date:   3 hours ago
> > > > config: sh-allmodconfig (attached as .config)
> > > > compiler: sh4-linux-gcc (GCC) 9.3.0
> > > > reproduce (this is a W=1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # https://github.com/0day-ci/linux/commit/ed0359e3fa64928e48021387a694f211bc840ff7
> > > >         git remote add linux-review https://github.com/0day-ci/linux
> > > >         git fetch --no-tags linux-review UPDATE-20210619-155350/Jhih-Ming-Huang/rtw_security-fix-cast-to-restricted-__le32/20210616-131056
> > > >         git checkout ed0359e3fa64928e48021387a694f211bc840ff7
> > > >         # save the attached .config to linux build tree
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sh
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > All warnings (new ones prefixed by >>):
> > > >
> > > >    drivers/staging/rtl8723bs/core/rtw_security.c: In function 'rtw_wep_decrypt':
> > > > >> drivers/staging/rtl8723bs/core/rtw_security.c:95:9: warning: variable 'crc' set but not used [-Wunused-but-set-variable]
> > > >       95 |  __le32 crc;
> > > >          |         ^~~
> > > >
> > > > Kconfig warnings: (for reference only)
> > > >    WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
> > > >    Depends on SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && HAS_DMA
> > > >    Selected by
> > > >    - SND_ATMEL_SOC_SSC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC
> > > >    - SND_ATMEL_SOC_SSC_PDC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && ATMEL_SSC
> > > >
> > > >
> > > > vim +/crc +95 drivers/staging/rtl8723bs/core/rtw_security.c
> > > >
> > > >     91
> > > >     92  void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
> > > >     93  {
> > > >     94          /*  exclude ICV */
> > > >   > 95          __le32 crc;
> > > >     96          signed int      length;
> > > >     97          u32 keylength;
> > > >     98          u8 *pframe, *payload, *iv, wepkey[16];
> > > >     99          u8  keyindex;
> > > >    100          struct  rx_pkt_attrib    *prxattrib = &(((union recv_frame *)precvframe)->u.hdr.attrib);
> > > >    101          struct  security_priv *psecuritypriv = &padapter->securitypriv;
> > > >    102          struct arc4_ctx *ctx = &psecuritypriv->recv_arc4_ctx;
> > > >    103
> > > >    104          pframe = (unsigned char *)((union recv_frame *)precvframe)->u.hdr.rx_data;
> > > >    105
> > > >    106          /* start to decrypt recvframe */
> > > >    107          if ((prxattrib->encrypt == _WEP40_) || (prxattrib->encrypt == _WEP104_)) {
> > > >    108                  iv = pframe+prxattrib->hdrlen;
> > > >    109                  /* keyindex =(iv[3]&0x3); */
> > > >    110                  keyindex = prxattrib->key_index;
> > > >    111                  keylength = psecuritypriv->dot11DefKeylen[keyindex];
> > > >    112                  memcpy(&wepkey[0], iv, 3);
> > > >    113                  /* memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[psecuritypriv->dot11PrivacyKeyIndex].skey[0], keylength); */
> > > >    114                  memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[keyindex].skey[0], keylength);
> > > >    115                  length = ((union recv_frame *)precvframe)->u.hdr.len-prxattrib->hdrlen-prxattrib->iv_len;
> > > >    116
> > > >    117                  payload = pframe+prxattrib->iv_len+prxattrib->hdrlen;
> > > >    118
> > > >    119                  /* decrypt payload include icv */
> > > >    120                  arc4_setkey(ctx, wepkey, 3 + keylength);
> > > >    121                  arc4_crypt(ctx, payload, payload,  length);
> > > >    122
> > > >    123                  /* calculate icv and compare the icv */
> > > >    124                  crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
> > > >    125
> > > >    126          }
> > > >    127  }
> > > >    128
> > > >
> > > > ---
> > > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > > 
> > > This warning was introduced by my pull request,
> > > but I am fixing the sparse warning and the unused variable was
> > > declared in the previous commit.
> > > The original author did not compare the crc and payload in
> > > rtw_wep_decrypt, so the variable 'crc' was set but not used.
> > > 
> > > Should I fix this in my pull request?
> > 
> > We do not do "pull requests" in the kernel development process for
> > normal changes.  Just send a patch like normal for this and I will be
> > glad to apply it to my trees and send it onward.
> > 
> > thanks,
> > 
> > greg k-h
> 
> thanks for your fast reply.
> 
> should I send the other patch based on my original patch or I should combine
> these two patches into one patch?

What ever will be able to be applied to my tree is what I need.  I can
not remove an existing patch from it.  If I have not accepted the patch,
then a new patch is required.

thanks,

greg k-h
