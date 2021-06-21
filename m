Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7CA3AE389
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 08:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFUGym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 02:54:42 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34289 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFUGyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 02:54:41 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D34615C009A;
        Mon, 21 Jun 2021 02:52:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 21 Jun 2021 02:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=fVBNFAIC+o0Qr3V3e8/8B3LGO4o
        YUVLp/J0au7zPfBE=; b=ittxmqKzyd8JOXXwLwhsQNyioIk3W5OYIYElIsRQDM8
        j1AsckJs6sMPdFKBOrTC/lGqRYy2P7Y+b89FCnrYt94+L6+6oEFBi6VKsIuZqJRm
        Jd8lzf/VybhlJ+VXgXw5S785XPxl9diUvCNPpnaCulfXFE0JVeDxu58I9tCYRsg/
        5jScc79UU7sWlEgHXbzxxsl3Nq9QHbK+qGS3O5EegsnBVkUiia8M4iAyiAOmHgz7
        r559G3hhjtcqh3/LdW7X/1ubGM7l67BivHZLyD3Soxnvv7C2C+0YyOM0L/8JHut6
        5yijizcbMs3fOvkMDr+s/ZeU/9YrTkKNQ7mUbKkaiFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=fVBNFA
        IC+o0Qr3V3e8/8B3LGO4oYUVLp/J0au7zPfBE=; b=UFfUp98ti3YvtEm9W/KNaZ
        KLgcY0YN/a3aNF2W30+7L+XTaO3HkUYI+7/8CMOP2G/b54haBhSkin3WCUdKAuFx
        uiNQycpaUkICMJ3uUTCf/ktPP6xGIFtJh0AVU8WKwwLiaR5FOotmEc9NryqURrYs
        MMTaZn6f2t+xXQqPhkDxCLkBgr1PiVoXuTBdsgTSIAnB22x4YOv6U3MCL8L3SKIH
        S1I2z9U0CFPQeCtZtkLOxiI7OiqFnXZPsCPdWr51TtRjCv4bdwKJGJv2IVEf3hb9
        nraLlT9FXSPNB+PlKaHhR1KF2qv5cDK0/VD7N5mX+thrvKMHEYF+ndtbr9fnEA5Q
        ==
X-ME-Sender: <xms:KzfQYEdZR89eG--dyT8Wldog9pF6KUDftlg6dfz4Y8TYqW2V31FAmw>
    <xme:KzfQYGPpAINwsgr3m353vHiVsczYG2efaYftf-3OdGgsx91gdtIWemRELVSfaUR_5
    sjgCPKPM2fNWw>
X-ME-Received: <xmr:KzfQYFiptpHsKTkvsfatCpvYi_9zQp4BFDvI8v-DxVZjfHc1IoHWMIENxxXQr2uMp8zWP9s5SIbEHEy6Wv2laPWFdU1U4H24>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefkedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeettdeffeegffeuveeffefftedvuefhiedvvdehjedvfe
    etvddvteethfeiiefgudenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhthhhu
    sghushgvrhgtohhnthgvnhhtrdgtohhmpddtuddrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:KzfQYJ-W7thFG3TAWaMUrZZC1zD4zPaWV0A1ROX7MLNJ3gmrW80g4Q>
    <xmx:KzfQYAvAwLFi-ZAhwUNuI6IAA_AL5WvN5ByuTI20jm2FboxHPG9AUg>
    <xmx:KzfQYAFDpvBhhG_AMYZaCLHvovke9mvRjfBpKs_HU0w0YeWrwlIVbQ>
    <xmx:KzfQYCJZ0HBjlfyKwHi5nxtFU_OrqYjlTNFzdGNjc5ZiZBY_m7_51w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jun 2021 02:52:27 -0400 (EDT)
Date:   Mon, 21 Jun 2021 08:52:24 +0200
From:   Greg KH <greg@kroah.com>
To:     Jhih-Ming Huang <fbihjmeric@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [fbihjmeric@gmail.com: Re:
 drivers/staging/rtl8723bs/core/rtw_security.c:95:9: warning: variable 'crc'
 set but not used]
Message-ID: <YNA3KAxTeXsb35/W@kroah.com>
References: <20210621063041.v4u35pxgglgwn2go@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621063041.v4u35pxgglgwn2go@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 02:30:41PM +0800, Jhih-Ming Huang wrote:
> On Sat, Jun 19, 2021 at 6:27 PM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://github.com/0day-ci/linux/commits/UPDATE-20210619-155350/Jhih-Ming-Huang/rtw_security-fix-cast-to-restricted-__le32/20210616-131056
> > head:   ed0359e3fa64928e48021387a694f211bc840ff7
> > commit: ed0359e3fa64928e48021387a694f211bc840ff7 rtw_security: fix cast to restricted __le32
> > date:   3 hours ago
> > config: sh-allmodconfig (attached as .config)
> > compiler: sh4-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/0day-ci/linux/commit/ed0359e3fa64928e48021387a694f211bc840ff7
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review UPDATE-20210619-155350/Jhih-Ming-Huang/rtw_security-fix-cast-to-restricted-__le32/20210616-131056
> >         git checkout ed0359e3fa64928e48021387a694f211bc840ff7
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sh
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/staging/rtl8723bs/core/rtw_security.c: In function 'rtw_wep_decrypt':
> > >> drivers/staging/rtl8723bs/core/rtw_security.c:95:9: warning: variable 'crc' set but not used [-Wunused-but-set-variable]
> >       95 |  __le32 crc;
> >          |         ^~~
> >
> > Kconfig warnings: (for reference only)
> >    WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
> >    Depends on SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && HAS_DMA
> >    Selected by
> >    - SND_ATMEL_SOC_SSC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC
> >    - SND_ATMEL_SOC_SSC_PDC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && ATMEL_SSC
> >
> >
> > vim +/crc +95 drivers/staging/rtl8723bs/core/rtw_security.c
> >
> >     91
> >     92  void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
> >     93  {
> >     94          /*  exclude ICV */
> >   > 95          __le32 crc;
> >     96          signed int      length;
> >     97          u32 keylength;
> >     98          u8 *pframe, *payload, *iv, wepkey[16];
> >     99          u8  keyindex;
> >    100          struct  rx_pkt_attrib    *prxattrib = &(((union recv_frame *)precvframe)->u.hdr.attrib);
> >    101          struct  security_priv *psecuritypriv = &padapter->securitypriv;
> >    102          struct arc4_ctx *ctx = &psecuritypriv->recv_arc4_ctx;
> >    103
> >    104          pframe = (unsigned char *)((union recv_frame *)precvframe)->u.hdr.rx_data;
> >    105
> >    106          /* start to decrypt recvframe */
> >    107          if ((prxattrib->encrypt == _WEP40_) || (prxattrib->encrypt == _WEP104_)) {
> >    108                  iv = pframe+prxattrib->hdrlen;
> >    109                  /* keyindex =(iv[3]&0x3); */
> >    110                  keyindex = prxattrib->key_index;
> >    111                  keylength = psecuritypriv->dot11DefKeylen[keyindex];
> >    112                  memcpy(&wepkey[0], iv, 3);
> >    113                  /* memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[psecuritypriv->dot11PrivacyKeyIndex].skey[0], keylength); */
> >    114                  memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[keyindex].skey[0], keylength);
> >    115                  length = ((union recv_frame *)precvframe)->u.hdr.len-prxattrib->hdrlen-prxattrib->iv_len;
> >    116
> >    117                  payload = pframe+prxattrib->iv_len+prxattrib->hdrlen;
> >    118
> >    119                  /* decrypt payload include icv */
> >    120                  arc4_setkey(ctx, wepkey, 3 + keylength);
> >    121                  arc4_crypt(ctx, payload, payload,  length);
> >    122
> >    123                  /* calculate icv and compare the icv */
> >    124                  crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
> >    125
> >    126          }
> >    127  }
> >    128
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> This warning was introduced by my pull request,
> but I am fixing the sparse warning and the unused variable was
> declared in the previous commit.
> The original author did not compare the crc and payload in
> rtw_wep_decrypt, so the variable 'crc' was set but not used.
> 
> Should I fix this in my pull request?

We do not do "pull requests" in the kernel development process for
normal changes.  Just send a patch like normal for this and I will be
glad to apply it to my trees and send it onward.

thanks,

greg k-h
