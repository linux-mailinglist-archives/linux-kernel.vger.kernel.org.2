Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C016F4580B3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 22:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhKTVy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 16:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhKTVyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 16:54:55 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EFAC061574;
        Sat, 20 Nov 2021 13:51:51 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so22496605otm.10;
        Sat, 20 Nov 2021 13:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NY1Fi+OAo8NQyf3et78wQgnWi0yCaD3WSiqHchLq/1o=;
        b=MGcjuhq+WQWuXFaQDFQwyC8Hw7bcd5ehd9p6kEXJaz1x0JH9iDjuPMyf64EfiTCGqH
         RFQ60tTbkC+PAiltPuB0EH+xke8kCXDnKWhB8ptF6cV73O2jNjtbcQbKvGtXNuBSgSpO
         jRr7gh262lDoV/U3KwzGS1Ic5KMT3Sptr4FxmcE1EtppemfJBUuNljzUytmnnVt0EOQO
         3hWDT5Vh0fazE6AYHpk1IqLE0H0EMn9BB4268bp9nWSa87OGgt+nyKqguOZpFL+4Uu7L
         1PPYr0KBpLxCwpmLHx5j/FM3jByD8l8ksLynIUUkaS52O+EnVEingSUuwN9SKOsv9dfs
         /8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NY1Fi+OAo8NQyf3et78wQgnWi0yCaD3WSiqHchLq/1o=;
        b=4nmeUK1NXoHUTGmQWPPrKH7QaphQ+rutk+AtGce99dIH2ntPIxaCGbgj5G2d3/FtZm
         XbIQFjFFC+2G4GbO//8QY0HCMnKpGIhAphA/psOZ3fGHn7tdRe7wqHf317L+1WhBvlFg
         gNKcfc5kiRErpkGjTA7me3m7nZhAUm4fBQMGVXAxyL9Y2Ck865mCE9eBfaX06uPHpM4b
         HToZmvJgaOrt1wok7nrzQm0P7YY554niMJz0P85D0EaIkU+NHnzAnH7zi8QnVKEQeXAk
         lrhrx4Gvln+zmMZVAwNwGSoOOeVP3WM9JAZs9k/vmb1SG+kQWpQKXqG5aUVC6VhaJ7L9
         kLLg==
X-Gm-Message-State: AOAM533w9kYD8azOyBqI/7N3QuHrUfI0qFGIjLbiAvG7fPRZ29XL50zV
        33gd4R0YrUzp0dfPwG/ByLo=
X-Google-Smtp-Source: ABdhPJwTWqnTUeQy7WPB12b34VQsQUk+SIsQzX3Q5sKvNDmo1EeNkNykamJ+0Xzcx4iIewg3fVT0ng==
X-Received: by 2002:a9d:6216:: with SMTP id g22mr14749258otj.46.1637445110744;
        Sat, 20 Nov 2021 13:51:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o6sm725198oou.41.2021.11.20.13.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 13:51:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 20 Nov 2021 13:51:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Mosberger-Tang <davidm@egauge.net>
Cc:     Navin Sankar Velliangiri <navin@linumiz.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (sht4x) Add device tree match table and
 document it
Message-ID: <20211120215148.GA1291159@roeck-us.net>
References: <20211120204053.2299501-1-davidm@egauge.net>
 <20211120204053.2299501-2-davidm@egauge.net>
 <4ebe1f6a-575f-2d34-7839-9055545e5e6b@roeck-us.net>
 <5f5798b3f021c419e94714ba557be0e3a40c671e.camel@egauge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f5798b3f021c419e94714ba557be0e3a40c671e.camel@egauge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 02:36:39PM -0700, David Mosberger-Tang wrote:
> On Sat, 2021-11-20 at 13:12 -0800, Guenter Roeck wrote:
> > On 11/20/21 12:40 PM, David Mosberger-Tang wrote:
> > > This patch enables automatic loading of the sht4x module via a device
> > > tree table entry.
> > > 
> > > Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
> > > ---
> > >   .../bindings/hwmon/sensirion,sht4x.yaml       | 50 +++++++++++++++++++
> > >   drivers/hwmon/sht4x.c                         |  7 +++
> > 
> > This needs to be two separate patches, one the devicetree change and the other
> > the source code change. DT maintainers need to be copied on the devicetree
> > patch.
> 
> Isn't that going to be confusing if one but not the other patch makes
> it into a repository?  Either you end up with an undocumented device
> tree property or you end up with documentation for an unsupported
> property.
> 
This is a trivial device, so that isn't really an issue. Otherwise,
if there are real bindings to approve, I would not accept the patch
making the code change unless the devicetree patch is approved,
and I would typically apply both together.

Anyway, those are the rules. Devicetree patches need to be sent
separately and approved by a devicetree maintainer. We should not
[have to] discuss rules here. If you are unhappy with it, I would
suggest to start a discussion on the devicetree mailing list and
suggest alternatives.

Thanks,
Guenter
