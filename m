Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B335340F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 22:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhCRVBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 17:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhCRVAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:00:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C10C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:00:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l4so6135525ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDRaT+1opSF5K6EEMWdukxpkO3tehbQx/HNL6zQDZ7M=;
        b=BA/kE/FMYVJ3NONdl9km1C+zfiHpkR6W3Wt4J67A6OqIyAFBPrtYrzFH9tPzd1j0Yt
         hFdbQ4Yc/ID31JTMgv/aRScZ4KKE0ouaGBR+JWb5ni1dgbfGby0Roy8lQfcvLnY8a/iL
         t+EV7XxyBZ31nj6NGLDsExf669wy34Oit5QOWKPK5wJ7MoSVG3jt3AxndSojgnADQmp1
         bntkzfVtcZJZnjek58NxVLR5COuuMuGniFF0MgMUHCF044kfgVfzBURyfHxXlGMhEbV/
         hjg5YfI/pBuOijvuVQJtkKXw+yL1sj2JGjthRDjHbW/3ArxNXtfGrZ6yMxMtBaVHRXxT
         LEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDRaT+1opSF5K6EEMWdukxpkO3tehbQx/HNL6zQDZ7M=;
        b=KeoXDcZOyATqgcXwxOOc2A8jAbqkNl9es9AMdykWm0lfpNbyr8wXcmNCdUCDrnoydV
         qySiOld2MdSEcy5a977am5BDtoqXjCL+Mb2mvt8sXb9lTpAiJgv9UHWq0nJbIYPkF+kR
         yB+Wd/OYJLmB8GXcTDNTuTNVU2qLjuMiBnZB/9cFZTaDHuqAUFaA1g2S/dUVaJ7BiJQO
         W1hDc5etmWcgrqpumP4l952OEx1gXx0Xs+QY1snDEEMrc0f1tbuVCQQNiVY+G0RyGMfs
         3fu4ZF3/C/p/5NQTJsmrN7RE+nLfezxlQbIJA9M6fZTl+zyZoK9kSPmAt4SAsBr+/91P
         OTIQ==
X-Gm-Message-State: AOAM5339eb+2dw3tI/Mk+stbng8MUYtVMCPZ+fKCksbwEpywmXdqo7qq
        yHK0ASyJpU/LHV5q6Yz44lKI9eCZYzt+jt+dwRqF
X-Google-Smtp-Source: ABdhPJzvkfTBKXgICpiaIqwEj38i1nPgC33twBN/X/q1rZz7oyhL/NI/gA2+brbwCuFPGTdIuCyd5O8ffRPkkkZsTb0=
X-Received: by 2002:a17:906:3d62:: with SMTP id r2mr512557ejf.488.1616101230209;
 Thu, 18 Mar 2021 14:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616095045.git.rgb@redhat.com> <9543e42a75dd86bc0bed1f6cf735edc2169dc0b9.1616095045.git.rgb@redhat.com>
In-Reply-To: <9543e42a75dd86bc0bed1f6cf735edc2169dc0b9.1616095045.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Mar 2021 17:00:19 -0400
Message-ID: <CAHC9VhRv4CizkPGihkzB00hF2xo2UwxSBrQxpvWYGWDwDEdDsA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] audit: document /proc/PID/sessionid
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 3:19 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Describe the /proc/PID/loginuid interface in Documentation/ABI/stable that
> was added 2008-03-13 in commit 1e0bd7550ea9 ("[PATCH] export sessionid
> alongside the loginuid in procfs")
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  Documentation/ABI/stable/procfs-audit_loginuid | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
