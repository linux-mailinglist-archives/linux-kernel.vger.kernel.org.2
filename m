Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B9045DAFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355046AbhKYNYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354981AbhKYNVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:21:53 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796E6C06175A;
        Thu, 25 Nov 2021 05:16:46 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id m5so5770640ilh.11;
        Thu, 25 Nov 2021 05:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tp5L2HePrApdGGXc9126QVm8Qy0Sf8qHsve/I/GJKWs=;
        b=FGMq8dkNQ3xCbZueL8/dmCa39fEq07AVuLfeV9jILHdusRx8zzO0hPCQPydALozZHL
         KAHdS+rpt+tSQWX5SJpqUUTGXiCjLN8f/6SxYJkhXFPrK1KT4Ov2pbRR4o5SNAWOtBAT
         r//zN26NXo6rA8k/gJEoS3gljUVGE90+xuY3SCXrhnrT3OlofsdhLPbsZK4krw50QLbp
         vZX0khQo0qui1PCjYu64XFk0fIrslk35Tg35ls29EHpLee7eUjt9vqCkO3XXxmxpHy1v
         LbsbEY6xoM13cNAfNouHoACjYYFk0id3vtTwaLnj37TS06xBN4u1OtO1vhLXI3VB3W4d
         IvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tp5L2HePrApdGGXc9126QVm8Qy0Sf8qHsve/I/GJKWs=;
        b=OVsxzgS571yIjp555ELMKqmehHVT6cnKyQ9NFnS/aBYkQW7RzejXkwAOMKVuW2RYnY
         AQbRk9/HuPvN05gyOKS7pzKRRIYVbNp174jsybd6IPOKZdOlffPgXucTyID/ZthclXsz
         fG+0vMjRxVf6e+Hm5Li6PxB82JW2R6UyXBFLxgbWED043UgPMcdKdHKVCuCcxg/g5YyS
         7kzCMxbVhbrseZBFfGmpmY19GZn82n5kBzqXQoU8P5No4zAdP7IjKY2qio47N40PD7xR
         MGV0qNGweL5Pb0zIT311P92oD/i1Ies1sXML8W1gOfUXVAEAAzQlCrnEtQbS/Mlt/bFh
         ch1Q==
X-Gm-Message-State: AOAM53026y1gwMT1T7Zmkbak2LLp0NSLPG1NEmwi5jac1xygXkCpZcqx
        qwBd9JSMnd8vztoUeGZN9n2UJZNkSCqE56a55l4=
X-Google-Smtp-Source: ABdhPJw89P3kA0toHOYNr5CzgR9zqNfASjsL11C9JF/wpCPdUr/A5RG6qkwPoJQusd6+S3/nFs/9YwSuPp7+XPv+2g0=
X-Received: by 2002:a92:ca0b:: with SMTP id j11mr21640002ils.289.1637846205922;
 Thu, 25 Nov 2021 05:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20211122212850.321542-1-pauk.denis@gmail.com> <20211122212850.321542-3-pauk.denis@gmail.com>
 <CAHp75Vfg7LKX-21+b6f5c34G4Y=ZUqrWRbfDt_quCiJe+By-Ww@mail.gmail.com> <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com>
In-Reply-To: <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 25 Nov 2021 14:16:35 +0100
Message-ID: <CAB95QASSWztLL2A9j2FdfaQK3HH1FBypAshdPH_W3vLg8iW24Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Implement custom lock by ACPI mutex.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 at 14:14, Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
> Denis worked on my code with the first attempt to read EC sensors from
> ASUS motherboards and submitted it as a driver named
> "asus_wmi_ec_sensors", which is not in hwmon-next.

Sorry, "which is NOW in hwmon-next".
