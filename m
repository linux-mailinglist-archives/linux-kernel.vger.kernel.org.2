Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8043ABE51
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 23:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhFQVpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 17:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhFQVpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 17:45:07 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91118C061574;
        Thu, 17 Jun 2021 14:42:59 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id x196so8120552oif.10;
        Thu, 17 Jun 2021 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XQF4JJu5A/7A1cff9DzYCX5Y/ToHTVViylZ/iOkMfNE=;
        b=pP10Yflkm6h1lvV67GGL420l42zyaNKicBdYNns5ClU7x2JmZCiW7JfwVArrjX+a+U
         /5NZ2BFGQIDS1GEvK+uCkKkqpu/5RLd0OnzWIEbLsbIKzrS2IwOfqpBpQdXzhBdfMMlh
         y7PYR55isMYuVx8DUKmaio4vAIqCtmjQntSsf96PCl2QJKY6BDnsTur07YNbjYhU65Tr
         oxLNPslTRcCYnKRfPokrfk8Ck6NSF+E0kCCiZNZIp/9L2/c8yUHhciJzROa5+kfZN/gE
         9eNMhwONl4ps5Lh7gdNkJPe9N8GSGgF9/83+0DxRh+S3UZjiFDXaNkC+zpoGbOPnNcfQ
         6wCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=XQF4JJu5A/7A1cff9DzYCX5Y/ToHTVViylZ/iOkMfNE=;
        b=g8YjRLpqwFsFlhR8wWPRI8ajnO9fiQ0ZAH5nOv0UhFgjdG9axmIIPrH2WUisYB3dg1
         QEuOfLHOf8tcnhz6JThF/pxgQlbs23SC1LwpgiW0VAUN+YaxdLhhkHveSPbEWkRLz2A/
         kWdOFC+UA1XJsxD7TzFBnCiupwutoqohhXzp+jZ6TvwZyynam4+agrIH6vdaxlxnRkae
         TJgwoAf5XiyQRf5QHZfzKVAffvlS5UuIgmouAGY4x+bi8svzWPgd9oeeOxn+B2dLKBeM
         DCh62vtBJtBofKz4l2urIXvP+vo9hW+5IMcgEX8QWznrDxcIcDj+DykHUGHIWjlKfZMn
         iUFg==
X-Gm-Message-State: AOAM531C7BO3m74PlTT+Vy07Qb0/2rajWu82mquwaETpg2B1SlNqMHi4
        dwMHMTecZgKo7mWb6/z5BZM=
X-Google-Smtp-Source: ABdhPJzSbslaDuCZ9+N/zF5+x4Kxb42edKzjPavQcki3VbkjX1KH4bLbhO8jLgmm1A/gpmEE0/46KA==
X-Received: by 2002:aca:4f52:: with SMTP id d79mr4679332oib.39.1623966179014;
        Thu, 17 Jun 2021 14:42:59 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d136sm1369482oib.4.2021.06.17.14.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:42:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 17 Jun 2021 14:42:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v1] hwmon: (lm90) Use edge-triggered interrupt
Message-ID: <20210617214257.GD2244035@roeck-us.net>
References: <20210616190708.1220-1-digetx@gmail.com>
 <20210617001243.GA3211292@roeck-us.net>
 <3c6cbaf3-187b-1682-69b8-a2b34f23b928@gmail.com>
 <20210617131205.GA59767@roeck-us.net>
 <de7682c2-ae34-c594-d237-330ea33cbc78@gmail.com>
 <20210617141300.GA1366442@roeck-us.net>
 <bc3e3595-fe10-c7ae-9560-0c7676facba2@gmail.com>
 <20210617151236.GB2676642@roeck-us.net>
 <b97e3a75-f1aa-95a4-187d-97dc95e57e2b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b97e3a75-f1aa-95a4-187d-97dc95e57e2b@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 06:27:50PM +0300, Dmitry Osipenko wrote:
> 17.06.2021 18:12, Guenter Roeck пишет:
> >> For now I see that the rising edge isn't needed, the TEMP_ALERT goes
> >> HIGH by itself when temperature backs to normal. But I will try to
> >> double check.
> >>
> > The point is that a sysfs event should be sent to userspace on both
> > edges, not only when an alarm is raised. But, you are correct,
> > IRQ_TYPE_EDGE_RISING is currently not needed since sysfs events
> > are not generated.
> 
> Ok, thank you for the clarification.
> 
> >>> Anyway, the tegra30 dts files in the upstream kernel either use
> >>> IRQ_TYPE_LEVEL_LOW or no interrupts for nct1008. The Nexus 7 dts file
> >>> in the upstream kernel has no interrupt configured (and coincidentally
> >>> it was you who added that entry). Where do you see IRQ_TYPE_LEVEL_HIGH ?
> >> I have a patch that will add the interrupt property, it's stashed
> >> locally for the next kernel release.
> >>
> >> IIUC, it's not only the Tegra30 dts, but all the TegraXXX boards that
> >> use IRQ_TYPE_LEVEL_LOW are in the same position.
> > I still don't see a IRQ_TYPE_LEVEL_HIGH, though.
> 
> Could you please clarify why you're looking for HIGH and not for LOW?
> The TEMP_ALERT is active-low.

Because you stated earlier:

"... cargo-culted and wrong because they use IRQ_TYPE_LEVEL_HIGH ..."
                                             ^^^^^^^^^^^^^^^^^^^

Guenter

