Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4527C35DCAB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbhDMKpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343740AbhDMKp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:45:29 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236ACC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 03:45:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id l123so11155173pfl.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 03:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NJEs0OVIbEPu0niN8aqEV6/oMkDrOYYQ8S6g+FDY+1A=;
        b=bt+SWsRREEyZ8aGF2En2o3+UBIqn/QCQ9DJpF7VyNlNflyKIJlByhGVzBdU7aTFr58
         AD1b9sH/dahahuGyfLCJOT9VYjTjp+VZFv2Y11pMK1Zza7Pi19Pa6kHM3GSyc8i3f+um
         UIsDTBPoTll6H+73jlKzEulll3kD+ywexevz8FFliFFFKSxpMB+84PxqRi6GIPICsuXc
         rPIwHwS0xtdmOE7WDvvENu/nF0OMvVqvdeLmJbSojPjj3S6S5nQLocAVgtcSnH2WwOOj
         tSpcz6jOh1Y2urrtg5NI8Ajl74RkQkRWfMh54BVhdQMP80+R7cI5Of2VFRGHfFS0ASuA
         /H1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJEs0OVIbEPu0niN8aqEV6/oMkDrOYYQ8S6g+FDY+1A=;
        b=PjMiTFTSfDSZu2/V+YplLykcnVOdNDrdRdIVyIfhGdpUnt/01QaMlRqeavW1IHt+Yw
         MqCvEq0BqxQjwHa9EIC24E8tLbKUyDGBBBH2cHfk7Po2b9OI5FY+79N1r3d7/UjJY2VZ
         eglzhTy6TDrcJhIcxWR6XWz1Re/kLknF/WX2WH4uz/ibEvaVlWQ9AOfH4HA8RKkNrSA0
         U1mD0WPl+Q9ILJrfQ8MrpbY9HdY7t6KPYvRr6i0mhlUOxjcdBFcU4l580nEEJpUORadr
         yDWKivjLeQw42GqYnueW35s01IH418kf3njHoQE+s1r+qhR8OPxwmJOJnzHq28oPGyqT
         t4Bg==
X-Gm-Message-State: AOAM530NPViKrNuCeYH9TOXK/zzKNfv38kdNMdn48MNv8jlAhcA+wLPI
        pF7t9gPZ2+hi4dBuJo+VT8U=
X-Google-Smtp-Source: ABdhPJzkmnq2CdOTUZB7OPf0KEEyoGAWhwp4xVg0M2I3EF6YMyaSPr91k6VCLi9FUtkx27P1iat/Xw==
X-Received: by 2002:a63:f95a:: with SMTP id q26mr31695929pgk.25.1618310709544;
        Tue, 13 Apr 2021 03:45:09 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id f21sm1957426pjj.52.2021.04.13.03.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 03:45:09 -0700 (PDT)
Date:   Tue, 13 Apr 2021 16:15:03 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH v5 0/3] staging: rtl8192e: Cleanup patchset for style
 issues in rtl819x_HTProc.c
Message-ID: <YHV2LyXrJjVnMsyT@kali>
References: <cover.1618283232.git.mitaliborkar810@gmail.com>
 <YHVN0JRWqNDJYF3T@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHVN0JRWqNDJYF3T@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 09:52:48AM +0200, Greg KH wrote:
> On Tue, Apr 13, 2021 at 08:55:03AM +0530, Mitali Borkar wrote:
> > Changes from v4:-
> > [PATCH v4 1/3]:- No changes.
> > [PATCH v4 2/3]:- No changes.
> > [PATCH V4 3/3]:- Removed casts and parentheses.
> 
> This series does not apply cleanly, please rebase and resend.
>
Resend as v6? Does not apply cleanly as in? Were mails not threaded
properly?

> thanks,
> 
> greg k-h
