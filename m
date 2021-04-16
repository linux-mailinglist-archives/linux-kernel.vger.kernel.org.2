Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28523616CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 02:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbhDPAa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 20:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbhDPAaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 20:30:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11285C061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 17:30:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f8so30182230edd.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 17:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JQ+5PYFrCESqWTWXQG4TnqoQj2dB5lWApYO0AEnXqE=;
        b=Wj71gi/NPwcdU7VxwkIuTewf0E3DQtS1gGmF0wjZmgow4McMk8Sd87vKneMXrfWMyR
         6FqaKhlj+5LI5cqkUVAuPOJB9Gyv6nKbx7DZ4FlopTXBwNagwohiv0dZVTND9D8939D+
         s1Lza341vtLWJjpfQbkHfTMixPdYEYX/bvH9toXgXFjjGjoPSEk5AOoKZmQuzincMWRQ
         Zpzcx7sJ4/QeaSFKQNO5EC9DTkgaDSKaacoqNIm1GxGUmvrORBvdQAFjyT+5t60pnX4d
         jRGDej43vWjtYgu9TUXeNKG0pCQwNRBW9FErouAkzkJYeGMlIWQFy8vF1d7Ng5HnddvH
         r8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JQ+5PYFrCESqWTWXQG4TnqoQj2dB5lWApYO0AEnXqE=;
        b=qG1dJnTBdEFBertFQyBY+PisWdLzIbQMYc0WMMTZf2jrwXV65EAmhuchfFtES2//BT
         ScaIrHxzg249nLtIIa6QzM5dosXxj0edQGSqMTCurd0jENP1OVCckap4Y5dDXF+7D3aE
         wRpEZI9xL/DsGnJn3tp06JApgZ+Buqq6XDt4r5974B4JKgoiTkduSGt/qPWvbME/J+54
         JgQbfbM/n0qO4rNkC0KTlezQG5rqD4TnC7KHBGPffW4w7hlEd4MQ7u2uyi31F+wa0/Jg
         S8seEX8oDE2nXZwsuBtCvdGt6NIBEHLvx2SZuQW1NmHu844+IW3lIHCqc+yHwW+VrBHX
         xD7Q==
X-Gm-Message-State: AOAM530SzLQRun5yVB9y09nJ1CaPnfbp9p/9sAyPLO4uC/nn4WH+6wMA
        DL5uwZ50qE5vXGRJ+0ggK/rmYA3TXyXYSbhG6dPWKQ==
X-Google-Smtp-Source: ABdhPJwfb1ArxTcMuMtNmI6uf8uaS73DakGrcDRHPZUbCZBSneAIoOerIU60FngYTqOxTa3cHKfYbAFu9su7XL0GlgQ=
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr7428632edc.210.1618532998871;
 Thu, 15 Apr 2021 17:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210415232610.603273-1-ben.widawsky@intel.com> <20210415232610.603273-3-ben.widawsky@intel.com>
In-Reply-To: <20210415232610.603273-3-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Apr 2021 17:29:47 -0700
Message-ID: <CAPcyv4h6BeEhn0W4tkUqjj+2-XLMkEWab2SHq5mJNa0x4MRDkA@mail.gmail.com>
Subject: Re: [PATCH 3/3] cxl/mem: Demarcate vendor specific capability IDs
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 4:26 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Vendor capabilities occupy 0x8000 to 0xFFFF according to CXL 2.0 spec
> 8.2.8.2.1 CXL Device Capabilities. While they are not defined by the
> spec, they are allowed and not "unknown". Call this detail out in the
> logs to let users easily distinguish the difference.
>
> Fixes: 8adaf747c9f0b ("cxl/mem: Find device capabilities")

Would need the abbrev length fixup if this was a fix, but I don't
think I can justify this to Linus as a fix v5.12. It's new development
for the next merge window.

Same comment for patch2.
