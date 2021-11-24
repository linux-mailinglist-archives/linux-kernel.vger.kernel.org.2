Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1481345CE17
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 21:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbhKXUhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 15:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbhKXUhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:37:53 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14519C061574;
        Wed, 24 Nov 2021 12:34:43 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso6140438ots.6;
        Wed, 24 Nov 2021 12:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mS4HySlQjvLA0Eh6hx8Q415CZ5EeqmdP8px2xegynzo=;
        b=NvrVwpChSyHwXcEZoh/HXt0PZ1G5f+LsIj6H3rtcObZd0ZuIYo0Axwp2yMTpDsz1OJ
         3hJ8Mbj1Ml5B/QTMBQDIGOidkbUsju94Kp4MzxAhqU0ktu7qX5dMIX1IDeXGUTDASRcK
         uCJoRXMFnarkOSnPOTcJPqC1A+rOjmH+GtiCftglv5zDAC8c7knQceTtRCr6YyijE34p
         taDhAf9nFuFka4X7Ga5GTYZmLQ/STZEzl6iMUZuBqT7tYNna5B8dX6S0SzNwGhyG/cnK
         F34PMzTMIUXLEtO28M0TNTgJ1/EynxwvYE/wtqRcS8IT+sMj1W323WU4riZKkRa9FUXN
         o8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mS4HySlQjvLA0Eh6hx8Q415CZ5EeqmdP8px2xegynzo=;
        b=hPv6YLyUpY3Kjienz5zTPgula8ihGTckAV3Coi2DVJ/bWIwt+72DvYCQGYggfE/+gI
         +ujRVkeM3HGY0tQqIdySNsktZspHDEbXIp6VABmet2eRKezjGbYI3WcisK/w/u78MA1p
         nf0HmL+gwoygMuipEL84C8O71IYKDadazXaG0G/N2EzsKmuUP1H5/64hmFbRQRyu+aKw
         Kmkn0j2NtKsntjTt3LvY4W65oZV+fgUFyid8Svaoq5cJEZ2G4OFXu33HFl03/J4U7cCb
         AcC4u4WZ5Xvc8sFHXpLsAKALnso4ZdZes8JchNapm0hsOUI6BuIp6YqfB70WoiIJd8Tc
         2ngQ==
X-Gm-Message-State: AOAM532NGPdks1jStUz1gJzilD5qswD/ykPzkuSdgajy3dCS8VauZs9y
        EOapGB/bewnXcWKlmOP/YrQA5zBmfZ0=
X-Google-Smtp-Source: ABdhPJz5g50fspbB4X37CHDS7oUqBCm/dtswbS8q8rj9urzy3j8upXQ5Q6duILt85BbdT/OQeuhmqw==
X-Received: by 2002:a05:6830:1514:: with SMTP id k20mr15640704otp.147.1637786082493;
        Wed, 24 Nov 2021 12:34:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j20sm142559ota.76.2021.11.24.12.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 12:34:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 24 Nov 2021 12:34:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Babu Moger <babu.moger@amd.com>
Cc:     clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (k10temp) Support up to 12 CCDs on AMD Family
 of processors
Message-ID: <20211124203440.GA346758@roeck-us.net>
References: <163776976762.904164.5618896687524494215.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163776976762.904164.5618896687524494215.stgit@bmoger-ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 10:03:13AM -0600, Babu Moger wrote:
> The current driver can read the temperatures from upto 8 CCDs
> (Core-Complex Die).
> 
> The newer AMD Family 19h Models 10h-1Fh and A0h-AFh can support up to
> 12 CCDs. Update the driver to read up to 12 CCDs.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Applied to hwmon-next.

Thanks,
Guenter
