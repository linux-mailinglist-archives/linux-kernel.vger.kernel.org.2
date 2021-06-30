Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905FF3B8A8C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 00:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhF3Wh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 18:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbhF3Wgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 18:36:54 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7E0C0617AD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 15:34:23 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id r20so2761753qtp.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 15:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDBeFzOeSYMajUq4z+RXiKNq7rQAt1gBDq5Z6Cf+y/c=;
        b=eY7qay9OFBKD9WyfWcDfvsAExyXjD6G8Z7MCYiObz3P66eVyVXJDuYc4I4H7YBjv1G
         LOrUtyvR8gPD1V2BpTy+08a+Ws64UX1vkAYLpZLd18850iBLxI0L8S9SuvhqrNGW6P3M
         9XVRxoWLFj5l8WNxyarmxWFjieIpR/TkCxru8yAtgRTaeoz5Y81AN4OFx7Ttxg5zTudc
         hUzlfOSJmXGRmArpkrAuCpKCxEIIG0JjfcthhTAgXLvqT8+KdmL9PaRPTbPp3bPDRI4t
         czh1HsjsMrBNSQOqIFZbI0PlWCfRGLkcVX6DA3NFzy+SU5QHWZh8RnfvGULN8JDfDYuC
         ATDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDBeFzOeSYMajUq4z+RXiKNq7rQAt1gBDq5Z6Cf+y/c=;
        b=Oc/t352ATsobgZH0PT6uzN0DGnwIlctbUagN9qmetdHA6/BSXnm5SfNUfQjbJSTOOK
         05JcXua+lP1LT8bB0RVbESKlRDu8D6hbJ/xF6zvaXNSx4aSEp4F90+YGqueRuJ5MCgPm
         ldq3xmek1fGN/UDCvx5z/weh7GfKhkrrLjJwMDCauMfpyyz4NqZgRsOTNp9qL+bKrcp5
         7K2ECZgw/tK1xFK6Oui24QbCEPM7sm3dqrDuTWzgcT6V/voS3PV7d8pQAxPGiPdqyNNQ
         cweRGhd/D43uU4SQ/srleYSTThYiO2J/KNq3zffAtNysDMmJSWYSzivzrCfoyrOWu0xH
         5e2Q==
X-Gm-Message-State: AOAM531VWmhBxi6Eowhd9MlGWi7JksIjzvC8jsuLLW2//drcjlieBou5
        GhcTJ7lRWs9yF1UEDtqScQEZ2O/JoIzpiLNYak4RVw==
X-Google-Smtp-Source: ABdhPJwrSvGWPQao8zHcABCMuiXxI/BRQPB4DIe7y60UDvcfYfGul0J9WFL1LSjY4Je8Ohgl7IefoZENhmAxer+HXXc=
X-Received: by 2002:ac8:604:: with SMTP id d4mr33769426qth.304.1625092462907;
 Wed, 30 Jun 2021 15:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210630003406.4013668-1-paulburton@google.com>
 <20210630003406.4013668-2-paulburton@google.com> <20210630083513.1658a6fb@oasis.local.home>
 <YNzdllg/634Sa6Rt@google.com> <20210630173400.7963f619@oasis.local.home>
In-Reply-To: <20210630173400.7963f619@oasis.local.home>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 30 Jun 2021 18:34:11 -0400
Message-ID: <CAJWu+ooJzcTFBFPSqWE5oHe2_4Gt_GHXftcXutk5mm-UX_hUUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: Resize tgid_map to PID_MAX_LIMIT, not PID_MAX_DEFAULT
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Paul Burton <paulburton@google.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 5:34 PM Steven Rostedt <rostedt@goodmis.org> wrote:
[..]
> > Having said that I think taking a similar approach to saved_cmdlines
> > would be better than what we have now, though I'm not sure whether it'll
> > be sufficient to actually be usable for me. My use case is grouping
> > threads into processes when displaying scheduling information, and
> > experience tells me that if any threads don't get grouped appropriately
> > the result will be questions.
>
> I found a few bugs recently in the saved_cmdlines that were causing a
> much higher miss rate, but now it's been rather accurate. I wonder how
> much pain that's been causing you?
>
> Anyway, I'll wait to hear what Joel says on this. If he thinks this is
> worth 16M of memory when enabled, I may take it.

I am not a huge fan of the 16M, in Android we enable this feature on
all devices. Low end Android devices traced in the field are sometimes
1 GB and the added memory pressure may be unwelcome. Very least, maybe
make it optional only for folks who increase pid_max?

thanks,
-Joel
