Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AEB3AE392
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 08:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhFUG7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 02:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhFUG73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 02:59:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FC9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 23:57:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x22so6463207pll.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 23:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LWzeXBLwSTCoqSbunlzVfzKA94bfHLT2m1zWj9xVhaQ=;
        b=PLXnUJEwAiNioRGRcJQ13pejdr7S9wozwiZA45+n2hNMJdgQI+vb6ncq6o+YwP9kc4
         A3cGBIhbRHqu/S681fA8sNSv82vLSOkaU6TyxFZCGC5uFV9pgzFToCtl13TozkwHsHk0
         bVUGHytplB+9wMYRcV7Jp9kjO3lg/gKm0a2U7usWhUyyawH+jJ5cHf85GF2Zmshn9R1C
         Jb56muiQmCXg9qvAjeAjXHPNdu/NUKfwWb/p04tkE6pdz7dwGMBFs3TeUSZBekuxOnlS
         XF1svtLt38jw8BUzrmnwnWHcBoLA/I0xbpYEPx3l5+zbEyA7FmIo4tDMB2E1IBniUaGu
         eV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LWzeXBLwSTCoqSbunlzVfzKA94bfHLT2m1zWj9xVhaQ=;
        b=RPj3/acq3E+ci3BeLQQjFj4e5y4181VBAJj6fzHQeNUrzarLkqUihkegrev8UGXykd
         54SjFyfb1bOo3Qjc2OZJuaM7yYQL6929M9Dw5wsxN6weDBLB5PIYVq5LabgXX/vEO5aR
         YOLjj7jGUN4N0irKSEnN7UQ8L+HMg3J2rpFENnhgcGPxohJVxj9JM2ko0iY/R/huX7S/
         2F/7K1lVbEmN6iX+sR/aF731nxax5g6nbITv0VI6E+QmihoSBu4Nm5gWHk03FVib5eoy
         RK8qNgEGeNFuJHk3k44tCg6/SxEXu3DqD4OkQ+GqDPZDXxC93WMh9DNgnBMkPpJbet/V
         iI/A==
X-Gm-Message-State: AOAM532OPD9HZiXqnuMAGN4fSjqYiV+/uNrYpwRzcSsKGS+2on/YseGD
        E5Tn1KBJANC1oKYYN7nFfTr+iJPdAoDDlQ==
X-Google-Smtp-Source: ABdhPJw0u9RrIlGt9PPk6L7la1w6dOE7U+bN5xauDSIyQNoXeffwWDSVljIfMFW3S9tVCaxVe6s4lA==
X-Received: by 2002:a17:90b:10e:: with SMTP id p14mr19507729pjz.153.1624258633835;
        Sun, 20 Jun 2021 23:57:13 -0700 (PDT)
Received: from gmail.com (36-229-229-123.dynamic-ip.hinet.net. [36.229.229.123])
        by smtp.gmail.com with ESMTPSA id d6sm15516485pgq.88.2021.06.20.23.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 23:57:13 -0700 (PDT)
Date:   Mon, 21 Jun 2021 14:57:09 +0800
From:   Jhih-Ming Huang <fbihjmeric@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [fbihjmeric@gmail.com: Re:
 drivers/staging/rtl8723bs/core/rtw_security.c:95:9: warning: variable 'crc'
 set but not used]
Message-ID: <20210621065709.6ffzqujlt26evjjz@gmail.com>
References: <20210621063041.v4u35pxgglgwn2go@gmail.com>
 <YNA3KAxTeXsb35/W@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNA3KAxTeXsb35/W@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 08:52:24AM +0200, Greg KH wrote:
> On Mon, Jun 21, 2021 at 02:30:41PM +0800, Jhih-Ming Huang wrote:
> > On Sat, Jun 19, 2021 at 6:27 PM kernel test robot <lkp@intel.com> wrote:
> > >
> > > tree:   https://github.com/0day-ci/linux/commits/UPDATE-20210619-155350/Jhih-Ming-Huang/rtw_security-fix-cast-to-restricted-__le32/20210616-131056
> > > head:   ed0359e3fa64928e48021387a694f211bc840ff7
> > > commit: ed0359e3fa64928e48021387a694f211bc840ff7 rtw_security: fix cast to restricted __le32
> > > date:   3 hours ago
> > > config: sh-allmodconfig (attached as .config)
> > > compiler: sh4-linux-gcc (GCC) 9.3.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://github.com/0day-ci/linux/commit/ed0359e3fa64928e48021387a694f211bc840ff7
> > >         git remote add linux-review https://github.com/0day-ci/linux
> > >         git fetch --no-tags linux-review UPDATE-20210619-155350/Jhih-Ming-Huang/rtw_security-fix-cast-to-restricted-__le32/20210616-131056
> > >         git checkout ed0359e3fa64928e48021387a694f211bc840ff7
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sh
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > >    drivers/staging/rtl8723bs/core/rtw_security.c: In function 'rtw_wep_decrypt':
> > > >> drivers/staging/rtl8723bs/core/rtw_security.c:95:9: warning: variable 'crc' set but not used [-Wunused-but-set-variable]
> > >       95 |  __le32 crc;
> > >          |         ^~~
> > >
> > > Kconfig warnings: (for reference only)
> > >    WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
> > >    Depends on SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && HAS_DMA
> > >    Selected by
> > >    - SND_ATMEL_SOC_SSC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC
> > >    - SND_ATMEL_SOC_SSC_PDC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && ATMEL_SSC
> > >
> > >
> > > vim +/crc +95 drivers/staging/rtl8723bs/core/rtw_security.c
> > >
> > >     91
> > >     92  void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
> > >     93  {
> > >     94          /*  exclude ICV */
> > >   > 95          __le32 crc;
> > >     96          signed int      length;
> > >     97          u32 keylength;
> > >     98          u8 *pframe, *payload, *iv, wepkey[16];
> > >     99          u8  keyindex;
> > >    100          struct  rx_pkt_attrib    *prxattrib = &(((union recv_frame *)precvframe)->u.hdr.attrib);
> > >    101          struct  security_priv *psecuritypriv = &padapter->securitypriv;
> > >    102          struct arc4_ctx *ctx = &psecuritypriv->recv_arc4_ctx;
> > >    103
> > >    104          pframe = (unsigned char *)((union recv_frame *)precvframe)->u.hdr.rx_data;
> > >    105
> > >    106          /* start to decrypt recvframe */
> > >    107          if ((prxattrib->encrypt == _WEP40_) || (prxattrib->encrypt == _WEP104_)) {
> > >    108                  iv = pframe+prxattrib->hdrlen;
> > >    109                  /* keyindex =(iv[3]&0x3); */
> > >    110                  keyindex = prxattrib->key_index;
> > >    111                  keylength = psecuritypriv->dot11DefKeylen[keyindex];
> > >    112                  memcpy(&wepkey[0], iv, 3);
> > >    113                  /* memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[psecuritypriv->dot11PrivacyKeyIndex].skey[0], keylength); */
> > >    114                  memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[keyindex].skey[0], keylength);
> > >    115                  length = ((union recv_frame *)precvframe)->u.hdr.len-prxattrib->hdrlen-prxattrib->iv_len;
> > >    116
> > >    117                  payload = pframe+prxattrib->iv_len+prxattrib->hdrlen;
> > >    118
> > >    119                  /* decrypt payload include icv */
> > >    120                  arc4_setkey(ctx, wepkey, 3 + keylength);
> > >    121                  arc4_crypt(ctx, payload, payload,  length);
> > >    122
> > >    123                  /* calculate icv and compare the icv */
> > >    124                  crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
> > >    125
> > >    126          }
> > >    127  }
> > >    128
> > >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > 
> > This warning was introduced by my pull request,
> > but I am fixing the sparse warning and the unused variable was
> > declared in the previous commit.
> > The original author did not compare the crc and payload in
> > rtw_wep_decrypt, so the variable 'crc' was set but not used.
> > 
> > Should I fix this in my pull request?
> 
> We do not do "pull requests" in the kernel development process for
> normal changes.  Just send a patch like normal for this and I will be
> glad to apply it to my trees and send it onward.
> 
> thanks,
> 
> greg k-h

thanks for your fast reply.

should I send the other patch based on my original patch or I should combine
these two patches into one patch?

thanks.

--jmhuang
