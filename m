Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2103AE4B5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhFUIY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUIY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:24:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F81C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:22:42 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v12so8125372plo.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZfnxSoMfUVSSDlsLwp0WoW5E9lvPUyllvrQ8/9x9fLo=;
        b=Pq1hHK9RJgIPikajvGj85KADiwQEuKLSL5C/+AGosMjMpAuewjq3kPtHYvFliErquW
         Dy/C5wsHTujMyiVG705Dk14Pq40bu6NT/A+ICipcaIZ/D3OMovB1P2UUohN7CQHmYOKX
         hXz1gu6jk0HJAjW1XXt4efahnR9klmCmyuyX1cnyb5WpVbaJZfEqKCGY0ttXE/ESYPHg
         zipKK1RE3mCkmWfqVE3hJhArk9N4mwqPMG3ABYfybgsW68T7wYsRoyEhnKGuX4HabAKU
         MRGyZ/ZU0i4A/NhPhh75WEdCNzt0jE6FUham0iQH5/v9yMYzydQ740bMvEtw6yKJe/nj
         Z+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZfnxSoMfUVSSDlsLwp0WoW5E9lvPUyllvrQ8/9x9fLo=;
        b=R6NeU1DqDcUnMspoycHa7XPD9HHlT/6lOusOVQa4B2V2UA7easxX47lwjH1P6NcQXX
         L2Sm55s8i0TgtRRamL/DLuipCVp6G/HKE7X01whnVl2Im9VuXsZK0klDhRU5eH/7t59l
         qjyXGgWBBEr9IectQ8mQrwxNF+zOcl+AlxHG5Bb1IW7xsAI+8hV3cifgA0lw9bwIKQn6
         xV0cLKLGrapqbwPxVPkl4ZUaRdYd4bzmx2E1D2W9vYwiUv3+oofFHIEOdIyLL7rt0ASO
         tgSddbLxYhqXHw7k0HKZdg3yalTh6/fhBei8LIdanCU2SgiZETYFyZGWHU8Ut3qzAFmh
         5iow==
X-Gm-Message-State: AOAM533iD7KJ989+vpUzSeEjRiV0hRz4MrCJMHfrTeVm5LJJI4hMKzyq
        H1W3wsFZ3p8KSXLjazosh7c=
X-Google-Smtp-Source: ABdhPJxJKSr1RTmSGiHrxaEzMzm5hoT9ayOKkcibP7Qtd34i6z276Sl4xoSmR6arsd4XjBFcRtplTQ==
X-Received: by 2002:a17:902:d645:b029:11d:d075:cf43 with SMTP id y5-20020a170902d645b029011dd075cf43mr16832526plh.14.1624263761549;
        Mon, 21 Jun 2021 01:22:41 -0700 (PDT)
Received: from gmail.com (36-229-229-123.dynamic-ip.hinet.net. [36.229.229.123])
        by smtp.gmail.com with ESMTPSA id z18sm14128683pfe.214.2021.06.21.01.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 01:22:40 -0700 (PDT)
Date:   Mon, 21 Jun 2021 16:22:37 +0800
From:   Jhih-Ming Huang <fbihjmeric@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [fbihjmeric@gmail.com: Re:
 drivers/staging/rtl8723bs/core/rtw_security.c:95:9: warning: variable 'crc'
 set but not used]
Message-ID: <20210621082237.im2asbiyc65kyzol@gmail.com>
References: <20210621063041.v4u35pxgglgwn2go@gmail.com>
 <YNA3KAxTeXsb35/W@kroah.com>
 <20210621065709.6ffzqujlt26evjjz@gmail.com>
 <YNBJc1Xlh75yz9DB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNBJc1Xlh75yz9DB@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 10:10:27AM +0200, Greg KH wrote:
> On Mon, Jun 21, 2021 at 02:57:09PM +0800, Jhih-Ming Huang wrote:
> > On Mon, Jun 21, 2021 at 08:52:24AM +0200, Greg KH wrote:
> > > On Mon, Jun 21, 2021 at 02:30:41PM +0800, Jhih-Ming Huang wrote:
> > > > On Sat, Jun 19, 2021 at 6:27 PM kernel test robot <lkp@intel.com> wrote:
> > > > >
> > > > > tree:   https://github.com/0day-ci/linux/commits/UPDATE-20210619-155350/Jhih-Ming-Huang/rtw_security-fix-cast-to-restricted-__le32/20210616-131056
> > > > > head:   ed0359e3fa64928e48021387a694f211bc840ff7
> > > > > commit: ed0359e3fa64928e48021387a694f211bc840ff7 rtw_security: fix cast to restricted __le32
> > > > > date:   3 hours ago
> > > > > config: sh-allmodconfig (attached as .config)
> > > > > compiler: sh4-linux-gcc (GCC) 9.3.0
> > > > > reproduce (this is a W=1 build):
> > > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > > >         chmod +x ~/bin/make.cross
> > > > >         # https://github.com/0day-ci/linux/commit/ed0359e3fa64928e48021387a694f211bc840ff7
> > > > >         git remote add linux-review https://github.com/0day-ci/linux
> > > > >         git fetch --no-tags linux-review UPDATE-20210619-155350/Jhih-Ming-Huang/rtw_security-fix-cast-to-restricted-__le32/20210616-131056
> > > > >         git checkout ed0359e3fa64928e48021387a694f211bc840ff7
> > > > >         # save the attached .config to linux build tree
> > > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sh
> > > > >
> > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > >
> > > > > All warnings (new ones prefixed by >>):
> > > > >
> > > > >    drivers/staging/rtl8723bs/core/rtw_security.c: In function 'rtw_wep_decrypt':
> > > > > >> drivers/staging/rtl8723bs/core/rtw_security.c:95:9: warning: variable 'crc' set but not used [-Wunused-but-set-variable]
> > > > >       95 |  __le32 crc;
> > > > >          |         ^~~
> > > > >
> > > > > Kconfig warnings: (for reference only)
> > > > >    WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
> > > > >    Depends on SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && HAS_DMA
> > > > >    Selected by
> > > > >    - SND_ATMEL_SOC_SSC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC
> > > > >    - SND_ATMEL_SOC_SSC_PDC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && ATMEL_SSC
> > > > >
> > > > >
> > > > > vim +/crc +95 drivers/staging/rtl8723bs/core/rtw_security.c
> > > > >
> > > > >     91
> > > > >     92  void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
> > > > >     93  {
> > > > >     94          /*  exclude ICV */
> > > > >   > 95          __le32 crc;
> > > > >     96          signed int      length;
> > > > >     97          u32 keylength;
> > > > >     98          u8 *pframe, *payload, *iv, wepkey[16];
> > > > >     99          u8  keyindex;
> > > > >    100          struct  rx_pkt_attrib    *prxattrib = &(((union recv_frame *)precvframe)->u.hdr.attrib);
> > > > >    101          struct  security_priv *psecuritypriv = &padapter->securitypriv;
> > > > >    102          struct arc4_ctx *ctx = &psecuritypriv->recv_arc4_ctx;
> > > > >    103
> > > > >    104          pframe = (unsigned char *)((union recv_frame *)precvframe)->u.hdr.rx_data;
> > > > >    105
> > > > >    106          /* start to decrypt recvframe */
> > > > >    107          if ((prxattrib->encrypt == _WEP40_) || (prxattrib->encrypt == _WEP104_)) {
> > > > >    108                  iv = pframe+prxattrib->hdrlen;
> > > > >    109                  /* keyindex =(iv[3]&0x3); */
> > > > >    110                  keyindex = prxattrib->key_index;
> > > > >    111                  keylength = psecuritypriv->dot11DefKeylen[keyindex];
> > > > >    112                  memcpy(&wepkey[0], iv, 3);
> > > > >    113                  /* memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[psecuritypriv->dot11PrivacyKeyIndex].skey[0], keylength); */
> > > > >    114                  memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[keyindex].skey[0], keylength);
> > > > >    115                  length = ((union recv_frame *)precvframe)->u.hdr.len-prxattrib->hdrlen-prxattrib->iv_len;
> > > > >    116
> > > > >    117                  payload = pframe+prxattrib->iv_len+prxattrib->hdrlen;
> > > > >    118
> > > > >    119                  /* decrypt payload include icv */
> > > > >    120                  arc4_setkey(ctx, wepkey, 3 + keylength);
> > > > >    121                  arc4_crypt(ctx, payload, payload,  length);
> > > > >    122
> > > > >    123                  /* calculate icv and compare the icv */
> > > > >    124                  crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
> > > > >    125
> > > > >    126          }
> > > > >    127  }
> > > > >    128
> > > > >
> > > > > ---
> > > > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > > > 
> > > > This warning was introduced by my pull request,
> > > > but I am fixing the sparse warning and the unused variable was
> > > > declared in the previous commit.
> > > > The original author did not compare the crc and payload in
> > > > rtw_wep_decrypt, so the variable 'crc' was set but not used.
> > > > 
> > > > Should I fix this in my pull request?
> > > 
> > > We do not do "pull requests" in the kernel development process for
> > > normal changes.  Just send a patch like normal for this and I will be
> > > glad to apply it to my trees and send it onward.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > thanks for your fast reply.
> > 
> > should I send the other patch based on my original patch or I should combine
> > these two patches into one patch?
> 
> What ever will be able to be applied to my tree is what I need.  I can
> not remove an existing patch from it.  If I have not accepted the patch,
> then a new patch is required.
> 
> thanks,
> 
> greg k-h

got it. new patch is sent. 

thanks.

--jmhuang
