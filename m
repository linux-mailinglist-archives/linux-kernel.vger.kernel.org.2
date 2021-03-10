Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF41D334BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhCJWqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbhCJWpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:45:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58278C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:45:53 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so2145283wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=soIboN4xfAfabYw8+TZrm6REVDxdebEu0jRjZc3fWY8=;
        b=aGrWD5pye2WMLFXTjVBqn0uT7Q8chP+yTy1HzJhbAUH5mX5hjmURlnDouBqIziKgO1
         OkgXUAqnGEGQHMINGQD3mjEhlDPmZe0t74oXMBLl1upkiQvuJrS08COPRorK8KcuYiSv
         ljlwPobHQkcJY7p+XLp3l9nvRcIhnQQpyP/ue5noaJ/IReUpf9tPEQh3/DDM6lAQ15Xo
         Zd56AliXmhflJuJoOhGT0GXQWA7DxeiBCySrh3DeT1HozOHwulg/lKD/fx1fPhL1DJju
         Nx+A9KZ4J83M6ncmi/fB/YLkrY/MDyp+vIctK8fM+AOvdVqPUnfmrdSl62yd88jwJscG
         98bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=soIboN4xfAfabYw8+TZrm6REVDxdebEu0jRjZc3fWY8=;
        b=VHYMHFhCE5PdXCIvzg5i5kMK1TX20ED81QjwfWJBMkD5QCXolC0jFVXl1wmCw4ip3E
         XXpi7C0bKYhwTu1s5G4rdiNICRt0he3AIxmkfoT4D7i8nc8L4+wVNNQViE1AnPXnIOZX
         T8xyeLCc5pRs7JLAY7v2h3VE3kbWpCOmHaJh1es3Ja/ieO5OjUtxmVW4TxgxMr5uDMHw
         SQ7yhl9kstsjN5v6CvY5shjsw0qp7jZ2+9J3xhXVDe7KzOs3EF1ua0O4CnT2XilnQSMQ
         ePAFFFEwihy8EiIEWLw0cayJFPqMtrgJBZAU93KONaoQZc0Wl73de0BD1I7Ol1l5uhJB
         1wsg==
X-Gm-Message-State: AOAM532a5ZZXA9azs2fZehIYZBFE3EL0naAJFzrooFa8oMDsQLFANNq8
        kNy1JlNvMnZP4Vdjx0dpkZX7yx1vU28=
X-Google-Smtp-Source: ABdhPJxXjqAbBViVcslhDI7DIfZwi3TvtUOAi7ichOzdOHPx1dVObtdFwJHpD0aPAWNBF463kD7YJg==
X-Received: by 2002:a1c:9849:: with SMTP id a70mr5621206wme.48.1615416352118;
        Wed, 10 Mar 2021 14:45:52 -0800 (PST)
Received: from agape.jhs ([5.171.72.174])
        by smtp.gmail.com with ESMTPSA id t188sm844407wma.25.2021.03.10.14.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:45:51 -0800 (PST)
Date:   Wed, 10 Mar 2021 23:45:49 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Eric Curtin <ericcurtin17@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: align comments
Message-ID: <20210310224548.GA3399@agape.jhs>
References: <20210310153717.GA5741@agape.jhs>
 <YEjrEErDZTH47gto@kroah.com>
 <20210310160946.GA6421@agape.jhs>
 <CANpvso71zHTHJBduzrX7wx=gDN9mi2CEaXskF=TaZZoL-2+V_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpvso71zHTHJBduzrX7wx=gDN9mi2CEaXskF=TaZZoL-2+V_Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 10:27:53PM +0000, Eric Curtin wrote:
> Hi Fabio,
> 
> > I am sorry, I fear I don't understand, checkpatch.sh script says the patch is ok.
> > Where have I to add a ' ' (a blank?)?
> >
> > thank you,
> >
> > fabio
> >
> 
> I'm only responding to this because this email is doing a very good job
> of avoiding my filters somehow :) I think what Greg means is:
> 
> Change this:
> 
>  /*
> -op_mode
> -Set to 0 (HT pure) under the following conditions
> -       - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
> -       - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
> -Set to 1 (HT non-member protection) if there may be non-HT STAs
> -       in both the primary and the secondary channel
> -Set to 2 if only HT STAs are associated in BSS,
> -       however and at least one 20 MHz HT STA is associated
> -Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
> -       (currently non-GF HT station is considered as non-HT STA also)
> -*/
> + *op_mode
> + *Set to 0 (HT pure) under the following conditions
> + *      - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
> + *      - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
> + *Set to 1 (HT non-member protection) if there may be non-HT STAs
> + *      in both the primary and the secondary channel
> + *Set to 2 if only HT STAs are associated in BSS,
> + *      however and at least one 20 MHz HT STA is associated
> + *Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
> + *      (currently non-GF HT station is considered as non-HT STA also)
> + */
> 
> to this:
> 
>  /*
> -op_mode
> -Set to 0 (HT pure) under the following conditions
> -       - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
> -       - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
> -Set to 1 (HT non-member protection) if there may be non-HT STAs
> -       in both the primary and the secondary channel
> -Set to 2 if only HT STAs are associated in BSS,
> -       however and at least one 20 MHz HT STA is associated
> -Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
> -       (currently non-GF HT station is considered as non-HT STA also)
> -*/
> + * op_mode
> + * Set to 0 (HT pure) under the following conditions
> + *      - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
> + *      - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
> + * Set to 1 (HT non-member protection) if there may be non-HT STAs
> + *      in both the primary and the secondary channel
> + * Set to 2 if only HT STAs are associated in BSS,
> + *      however and at least one 20 MHz HT STA is associated
> + * Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
> + *      (currently non-GF HT station is considered as non-HT STA also)
> + * /
> 
> Like Dan said, you need a space after the '*'/
> 
> Is mise le meas/Regards,
> 
> Eric Curtin
> 
> Check out this charity that's close to my heart:
> 
> https://www.idonate.ie/fundraiser/11394438_peak-for-pat.html
> https://www.facebook.com/Peak-for-Pat-104470678280309
> https://www.instagram.com/peakforpat/

thank you, Eric :)
