Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9131320554
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 13:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhBTM31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 07:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhBTM3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 07:29:24 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1387C061786
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 04:28:43 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z6so3685077pfq.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 04:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ESd3043vocdc8o+OeJoJOtt6T7G5G9i+TGIhSY83bdM=;
        b=O7Xx0RKI+1/JnOfIoVGJmtCZwf+0Dp1zFYpyjiykwhuswrHpx+VuGiIaWUBeM1wImv
         e55KOygqLjHSqdLw2E5CgVBLia9d6uQljC3yBaYSPohHIisNTPuNCjE2F3R6l+KyFl+4
         yho+e/fwHKoALn6uH48VKxBVTDgnSjqKEusOVX/dxRyx0fcvyG66VoWRIxVav3yfTVsJ
         wUhpILcIrKbVBz01Q1dIhKSLEiSoWUmTtUu9cqBF5HO3ASK4GoHS1EXdwrnYqcU4hZ7P
         dmoUt/pAjrPBv0qKJqzX05uaWnPDfWRHuYChI6BB76v4EZNl7GzPcXzNJo2tkMUmx15a
         XEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ESd3043vocdc8o+OeJoJOtt6T7G5G9i+TGIhSY83bdM=;
        b=fmOpl5uIjwkNRRjLfBi4rBpWAgjHTXxibpdwZoogEom9DtzfUF2qgu1wNZpgk0H634
         7PctyZf67cV4Oh4VA5GAhLwSXpRm9RnCEalJK0z/M6D2DOcfm2K3t7hwo07asXHPIcwW
         mJtvoJ+qLhLwqCHzoiKH5gAmhIVxd7L/rbyK4W41nWq4Ngkdjw+m6oPnZ1/9Zb1QysQ2
         FSTxqK2M+LqeoshaGm5J8HOcXo4KFEmuqvUbePlm7g5EPDT6Sx4MEQP52h9IgKu4cde2
         NbXPwMUolSR0bZ6d4RkWAJnlzM+TS+CdlPSiKxCNUFztCdykyFYeesmUNXIk7Fbqmlnz
         9Mlw==
X-Gm-Message-State: AOAM530K0cObcfzpS/Ub2zQeiM6+nfuDKSJ9F8xAlKHg/rcU44juNRVF
        lB6vY+5U0FqOgKkGd/2m3GcoCpi9tIt+HQ7Yy9s=
X-Google-Smtp-Source: ABdhPJzjFC7oBDbOFW0hddXcBIOMRD9hX84QPMywDHk0Wxq+Q2yBnPOkRI4xvJPZXsuSAmDyK6kvSA==
X-Received: by 2002:a63:f156:: with SMTP id o22mr12664617pgk.384.1613824123064;
        Sat, 20 Feb 2021 04:28:43 -0800 (PST)
Received: from ?IPv6:2409:4064:2e1c:74bc:95c:a666:3473:ade0? ([2409:4064:2e1c:74bc:95c:a666:3473:ade0])
        by smtp.gmail.com with ESMTPSA id x15sm11873597pjq.47.2021.02.20.04.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Feb 2021 04:28:42 -0800 (PST)
Subject: Re: [PATCH] staging: wimax: i2400m: add space before open parenthesis
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sfr@canb.auug.org.au, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20210220104816.13263-1-sssraj.sssraj@gmail.com>
 <YDDuu6sRtSfWhnbY@kroah.com>
From:   RajMAIN <sssraj.sssraj@gmail.com>
Message-ID: <5dbde654-386b-2011-0020-729e41043f45@gmail.com>
Date:   Sat, 20 Feb 2021 17:58:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDDuu6sRtSfWhnbY@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-02-2021 16:42, Greg KH wrote:
> On Sat, Feb 20, 2021 at 02:48:16AM -0800, Rajesh Kumbhakar wrote:
>> netdev.c
> Why is this here?

You mean that filename? I thought I should mention it. Should I remove 
it and resubmit?

