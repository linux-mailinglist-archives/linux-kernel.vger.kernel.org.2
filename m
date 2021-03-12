Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C8A338866
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhCLJP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbhCLJPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:15:48 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA24EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:15:47 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l11so4375895wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uNaymeWh6w/U88+iWiJkSx0rbMj53oFGfAfvgSr6Ycs=;
        b=ok9MAF/IrE4WyI20/akQhJ7RgA/76AiNVkV2k2colkHyEED72TGPHB/b8HzesjIV6Q
         nqjYcXFdWuV7C7m6o0ak0NMLTf+cetxe4kP8ICwIFE0tlRkLfD2wLUutYMC1qlA/ZZDQ
         jmm+mZRLhmvZdjpsspxWt3zZdfhs3R4StCXatGYWolpUvQJbKZxoGeANnUue1zr4D3Cl
         edXEofelPa//rKwxUhnUzZuPjLtenOCtCXUmcfM4ZXTtAR6pzuGqT20Jjf05gUVpeROg
         WNkBM8rZ9HHm56/WunEVpM3+RzPsSVY7+Vd4/85S0V05TA3QZADE9e+zhs96yMpvkCQ/
         pqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uNaymeWh6w/U88+iWiJkSx0rbMj53oFGfAfvgSr6Ycs=;
        b=acAfNdsnucC8KE+lsZu5TvI5TcmnXc7+2Mib+GgxBXpZzMAYwmHjvE3SUOk8X1T+ET
         uGNlcjCBSQ2TBOOKb3RE9Du+T1HpGHEEK7Nd5QMLf1cYJYpi7Upwca9i85OpfaGXKF1J
         bNVH5QPUbm40tWlmA2zGAWYe27FnAdOoGX7LSXv4DDzTsUcBQdQtsPR7tSnXmJy9CVZh
         AfJaN9QDGuLKUoEs5c8W7Jk92ohm2e2pgSE8HaWLpR/wb+qnlbyo0+fUBCJ5m55tclWp
         ZlN1en1r+4QqFw8aaczpubwnauLiDMw6/ERjp+TwO8b3YyO4j7K4lnhfNHkh68p2kpp8
         c2ew==
X-Gm-Message-State: AOAM533+kZdI8QrNIWp3bpQWIrwRq9oml6koB8wJWZSoWmY+nffg3X3r
        3H9Uvp3JeJLRzscDX8cD0tA=
X-Google-Smtp-Source: ABdhPJyiEaSZKYzjoIJC3mpmLfRbsGSrKD5GvQivjs6DqXZ1d/jLM8KZVuv2fuf9wuMI0IHzxrzJtg==
X-Received: by 2002:a5d:5906:: with SMTP id v6mr12919731wrd.137.1615540546591;
        Fri, 12 Mar 2021 01:15:46 -0800 (PST)
Received: from agape.jhs ([5.171.81.107])
        by smtp.gmail.com with ESMTPSA id e8sm1443257wme.14.2021.03.12.01.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:15:46 -0800 (PST)
Date:   Fri, 12 Mar 2021 10:15:29 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Eric Curtin <ericcurtin17@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: align comments
Message-ID: <20210312091528.GA1577@agape.jhs>
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

Thank you Eric, community is the best resource ever :), hope to contribute
soon

Kind regards,

Fabio

