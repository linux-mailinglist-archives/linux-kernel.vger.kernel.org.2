Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B66334B95
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhCJW22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhCJW2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:28:04 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BDFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:28:04 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id h18so17152039ils.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3LFyuXpMRLIGA0oVb60X0seTa3J0valro1PxCcKN/DM=;
        b=Bm6RNvQzL9TLUqo1/qVst2cHgKfFa3uFxN3tpI6ntj8GoK6H/W9W3icW7MGOWpbxfw
         pxQpHipOcy/xDB+rwnbj1DH1pRlx+FjFFt/sSgqx60RWrsxOItCEwWQ0MQ7W3nUL16I4
         l97de7tWU0i25g5UGR180rWVT6wGiGNj2LzCQc2JAuU210ALVhezd7z7n3wQbV3Zguh/
         P0yma07fpERMRyjq31GIllM/ufbANTzYU82GKZJMKUtX7dIVTI008DUXj1NNQNeReZx2
         IjkCj3sIrbFom1Hi4FNszU8z5sA1SPR9QLwECTADTaCuNW/uJyujaLzqvXx7ztCDRaNG
         zaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3LFyuXpMRLIGA0oVb60X0seTa3J0valro1PxCcKN/DM=;
        b=iWEVzYhv/ChJRvkN9KbFJk5yM8S7Zjvr2inFH3tulVSfM4+TTEICXioFErQXkIu82g
         6JLDMGlaCOCj6XETOY+7YQeQJBkaKFzZ32D7xNPXuYUvawhTAzn9bu/QDhbe8ptA4O9w
         30elE/xuxRQVskZNmXKhp3NCs1Nnn2TNObAY3PwvuQegd8V1d/lGzhg+mTzSj4TfPuAj
         Y7OQZRRXqjhmIfr1Q33ya4FA4qFXY5B0XpVseziTC7arLna3FIQ0lwAmX6Z/G5shFPsj
         Go7bjdOttjnOCmKXHJ/4L+AfNUGoskzLkd6JFm+49/qsoC2RTAK7o23rfQ8IBSKFRpe6
         EoPA==
X-Gm-Message-State: AOAM5330BQvLGZsJh6RIk3zY7wdoCV7Z/cMwRhcO6tJk3KCPMn8/xOIS
        3iok2Za7+i4U+2evN9/Yla9dMtkkGqzBWvJwD3V8yfW4S9cfN+hC
X-Google-Smtp-Source: ABdhPJyQFVb7tR865Cpwi+PC3bE/sDFIfZ6SDS8RmoYjLr9lXCma8VECXcThFWDRs4JLlDxAgckQ4dAp9G6xdad1HiA=
X-Received: by 2002:a92:c24c:: with SMTP id k12mr3131280ilo.282.1615415284065;
 Wed, 10 Mar 2021 14:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20210310153717.GA5741@agape.jhs> <YEjrEErDZTH47gto@kroah.com> <20210310160946.GA6421@agape.jhs>
In-Reply-To: <20210310160946.GA6421@agape.jhs>
From:   Eric Curtin <ericcurtin17@gmail.com>
Date:   Wed, 10 Mar 2021 22:27:53 +0000
Message-ID: <CANpvso71zHTHJBduzrX7wx=gDN9mi2CEaXskF=TaZZoL-2+V_Q@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: align comments
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

> I am sorry, I fear I don't understand, checkpatch.sh script says the patch is ok.
> Where have I to add a ' ' (a blank?)?
>
> thank you,
>
> fabio
>

I'm only responding to this because this email is doing a very good job
of avoiding my filters somehow :) I think what Greg means is:

Change this:

 /*
-op_mode
-Set to 0 (HT pure) under the following conditions
-       - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
-       - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
-Set to 1 (HT non-member protection) if there may be non-HT STAs
-       in both the primary and the secondary channel
-Set to 2 if only HT STAs are associated in BSS,
-       however and at least one 20 MHz HT STA is associated
-Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
-       (currently non-GF HT station is considered as non-HT STA also)
-*/
+ *op_mode
+ *Set to 0 (HT pure) under the following conditions
+ *      - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
+ *      - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
+ *Set to 1 (HT non-member protection) if there may be non-HT STAs
+ *      in both the primary and the secondary channel
+ *Set to 2 if only HT STAs are associated in BSS,
+ *      however and at least one 20 MHz HT STA is associated
+ *Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
+ *      (currently non-GF HT station is considered as non-HT STA also)
+ */

to this:

 /*
-op_mode
-Set to 0 (HT pure) under the following conditions
-       - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
-       - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
-Set to 1 (HT non-member protection) if there may be non-HT STAs
-       in both the primary and the secondary channel
-Set to 2 if only HT STAs are associated in BSS,
-       however and at least one 20 MHz HT STA is associated
-Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
-       (currently non-GF HT station is considered as non-HT STA also)
-*/
+ * op_mode
+ * Set to 0 (HT pure) under the following conditions
+ *      - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
+ *      - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
+ * Set to 1 (HT non-member protection) if there may be non-HT STAs
+ *      in both the primary and the secondary channel
+ * Set to 2 if only HT STAs are associated in BSS,
+ *      however and at least one 20 MHz HT STA is associated
+ * Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
+ *      (currently non-GF HT station is considered as non-HT STA also)
+ * /

Like Dan said, you need a space after the '*'/

Is mise le meas/Regards,

Eric Curtin

Check out this charity that's close to my heart:

https://www.idonate.ie/fundraiser/11394438_peak-for-pat.html
https://www.facebook.com/Peak-for-Pat-104470678280309
https://www.instagram.com/peakforpat/
