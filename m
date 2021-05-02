Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3A7370B26
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 12:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhEBKuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 06:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhEBKuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 06:50:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10947C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 03:49:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x7so2570123wrw.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 03:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=14wL5KFM14T10cjzVY0XnZGJYXazi8PBUlOpJwjNunc=;
        b=nREaEzA6QKZzz1Gjy+2HaUaxSMyyAeroRIvvS5l+Vyh4GJ0CZwHosf9kz3Pp4fN9PR
         n/g8qZb2eWAfQzOrfjgahGJG3vNkhD2jd8+nfALQc0RclwfFWl0lFaQOIPIX/rHml6Ce
         2KVBAKeQP8XJtBigbYE552+kES8uMWeelykqlErFtU1m+81vP9j4bG6b51cJ90+bTcFp
         9l13XRUoKenYJeKvszGfTP+Lq3J5QLqX2zdFXxMY2zKMUMbrpw0TjqFAyn6OdV7YPcJQ
         JTgqiReHEbVtTGwHlS7k8hHk1BNWDjcQTSP/ifQm96Uw7jhFE7zoXgUq1dbv4E14U66r
         hV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=14wL5KFM14T10cjzVY0XnZGJYXazi8PBUlOpJwjNunc=;
        b=jJMJY9GesoOm+A8vIzdcj+ZO6qEVq1g3cT08uWYKkWNoeiaX2EbRwVQOnJGf32+AV5
         M3Ozyql0qYo8GVMDePz6lJTurMwniwx5XZkEo2Z2L5srRJlBzr8thckV82dyBYzM1xBj
         sn5K/mjwijMNZTIrA9G66QhOneXk3QpgstLrSMIfIq4/0OQAzz5IU9T03SO9Z/9WBz5L
         ETeq+e/Tf27RKHFuyLJSMSqGVyGHomEnu5ED1WCJa8r7MPk5EEpY7Lpa0obp/38Bw2TD
         ByoKQAmAUnBfVPtbJQcicEtAckvvRyCW7yJWcWRU6L8FaJqK2Tb/MGRyqkfDgB5XKBh6
         UO+w==
X-Gm-Message-State: AOAM5324QssRpxICUigcJ26idVp+zL3k6Ii7nGfiJmp949BrAvhsQmCR
        TmbxVw3v1HBaOuf5Y5aYSBF5Xw==
X-Google-Smtp-Source: ABdhPJyeUWOY/jViBQn/YcsM7Lll/IVddreD7pv1XbiXTOICY018jhYlwZInmluWQ6jughN5QbfI2w==
X-Received: by 2002:a5d:6d48:: with SMTP id k8mr18279220wri.93.1619952556746;
        Sun, 02 May 2021 03:49:16 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id y21sm18744909wmc.46.2021.05.02.03.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 03:49:16 -0700 (PDT)
Date:   Sun, 2 May 2021 11:49:14 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH] fs: ext4: mballoc: amend goto to cleanup groupinfo
 memory correctly
Message-ID: <YI6DqtMHj9dx26Kw@equinox>
References: <YI0czH0auvWlU8bA@equinox>
 <6E6AEEB4-1FBA-40F1-8328-8E304E68A7C6@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6E6AEEB4-1FBA-40F1-8328-8E304E68A7C6@dilger.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2021 at 10:43:57AM -0700, Andreas Dilger wrote:
> On May 1, 2021, at 02:18, Phillip Potter <phil@philpotter.co.uk> wrote:
> > 
> > ﻿Hi All,
> > 
> > Sorry to be pushy (I know everyone is busy) but I've had no feedback on
> > this patch yet:
> > https://lore.kernel.org/linux-ext4/20210412073837.1686-1-phil@philpotter.co.uk/T/#u
> > 
> > Could I please ask for it to be reviewed? Many thanks.
> 
> Hi Phil,
> I've looked at the patch and it looks good. You can add my:
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> 
> Note in the future that it is a bit easier to review (IMHO) if you include the
> original patch in your ping email, but not a big deal. 
> 
> Cheers, Andreas

Dear Andreas,

Thank you for your review, really appreciate it :-) I will make sure I
include the original patch in future ping e-mails - wasn't sure as I
didn't want to annoy anyone. Have a great day.

Regards,
Phil
