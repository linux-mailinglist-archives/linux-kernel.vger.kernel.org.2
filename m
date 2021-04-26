Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7718936B4AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhDZOSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbhDZOSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:18:30 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D02C061574;
        Mon, 26 Apr 2021 07:17:48 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id a188-20020a4a4cc50000b02901f0ae7068a1so4271158oob.13;
        Mon, 26 Apr 2021 07:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+XfLmAGVjDqh4bLpk3FH98At1RwV7/JgpCPPTL5UDqA=;
        b=bCMMgG/l35c6tfRPhcsXkIe6TzFlIMp/H+Lg7wTFhSxTb8RB5BOBXij9O8JXKaSqkP
         9t8hcbVabGGELsFU1SJxJ6Y71G9r1MM7/TOwBxsd4U6OwYL+m9UYJ59pwYQV4GlX+RZV
         T4KNGyDwFxxJ5RInHNYQ79zFvUk4kxwmhVtayUbA5rxQEb0xcDiwiCsXNxuHpqJvmG8m
         34EhfBZ4m45IW676BOE0Yks48qqWPh3z1FhYGFx7qDG7luTKrZFKtvY0zIn73KWxz3v/
         X/gbx+r/lRrnY59lnfohoiN89vLQRqB17xrn0wa2IADI0ZzK3ze/1FndMfCgnSqa2C9H
         dDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+XfLmAGVjDqh4bLpk3FH98At1RwV7/JgpCPPTL5UDqA=;
        b=pRPTCx2+6eCz2GD7NFMLvzD2jtsTKCwJZUl33eYQ7V6x1/wtA2Cz7ddmk6g0IRXth3
         RRwAcXpz9DieOzl7Tt/lHVx+IOvnh5RUXWqTK41VSJgPdfd8emRghlGmnq0rcoHcdrdi
         O1tcvIcaqSS0PrhJE3My86n8Y7R4OXLwexNhQ2EFEoRjJwE0rkIXfUF33T2ugbJPY59Y
         aFDYJKS69zP1m32UwqX2eLPPJQEqYjoofQfeon5TrYL6sh1CV0A1zoDpzNmKLy+cZjVt
         XYFYe2GRNbDf2KRDI6jJmdn+aZxj4IXxzQlcJyGbyIv5hZ3lTuI0ivmfT2cMxQP0poL5
         bWZg==
X-Gm-Message-State: AOAM532ZC5hmT0ZXHH4wODqUZjsTjXQRGBid3qH0sWQ5PwGbEjkzJNV1
        w/ClslwFFgMOSb2ff63EBmI=
X-Google-Smtp-Source: ABdhPJwuTWLQy2jDoLqFc7IzHqUfX97rJz5dFgYVhIK7DziYo1Wjn6BcAFyBsliLkHstZdoTf8+lEQ==
X-Received: by 2002:a4a:4c43:: with SMTP id a64mr8182158oob.1.1619446668154;
        Mon, 26 Apr 2021 07:17:48 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g5sm3079937oiy.24.2021.04.26.07.17.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Apr 2021 07:17:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 26 Apr 2021 07:17:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?V=E1clav_Kubern=E1t?= <kubernat@cesnet.cz>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] hwmon: (max31790) Rework to use regmap
Message-ID: <20210426141745.GA257701@roeck-us.net>
References: <20210413025948.901867-1-kubernat@cesnet.cz>
 <250c1c16-541a-984f-c720-1a8b6176e97e@roeck-us.net>
 <CABKa3npjrpq5Aw_Xqy3mFZtUHZcfB0YENxEDgo_MCwPUKqA4ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABKa3npjrpq5Aw_Xqy3mFZtUHZcfB0YENxEDgo_MCwPUKqA4ww@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 02:46:27PM +0200, Václav Kubernát wrote:
> Hello.
> 
> I'm sending a new version of my patch on max31790. This new version
> fixes the cache issue and actually makes it work by setting
> .cache_type. You were right about the "yes/no" ranges, so I flipped
> those.
> 
> By the way, it seems that the reason your reply got lost is because of
> weird addresses in the "Cc:" email field, they end with "cesnet.cz",
> so it could be that I'm sending email incorrectly. Let me know if I'm
> doing something wrong.
> 

Yes, the To: field of your series is either empty (for the first patch
of the series), or it is something like:
	To: unlisted-recipients: no To-header on input <;

Also, you send your follow-up series as response of the previous series
which doesn't follow the guidance for submitting patches and may result
in the entire series getting lost.

Guenter
