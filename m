Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6899D425192
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbhJGK6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbhJGK6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:58:15 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26991C061746;
        Thu,  7 Oct 2021 03:56:22 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id x1so2301208iof.7;
        Thu, 07 Oct 2021 03:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23gZkYObBsS9Oz5ktS9sLtCgLLCB25YH4/s8PNfqgmI=;
        b=V3OGQW4hPGJ6lZQLXw+ruDHmH5KvebYrClY7D+6/GJACExdiAhHzLf4n8LNWRn1fLd
         VB7bDLWaOBF9cyD2gZoRnqQDNH0GYkaPJafzX7FeqI5fDnh19VtodYxatxP7pU0M56DF
         sPnCnsLfPu9MXnwj4CYb6+mVTEclSs05XpKu9OkUBAvOkl+sOXKRK6c0osdVp3Lcop4c
         7FFSCzBF727P75fzJZfwEGYO2FlM0jNxjFGCvDYGPwWu9MhJkbZgfgdTccU48RECrsDs
         TmfZ3b5bBwuc3cXqUAwOL4FK9GvUAqmYPTWY/XKo0PZididPiadxo4UmPLso0wZcdKpc
         S3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23gZkYObBsS9Oz5ktS9sLtCgLLCB25YH4/s8PNfqgmI=;
        b=jDSwdJInD6zknMJrB44XLr6NW5QgNxd7z0dO72cCFcdyZ+05g1wCfP3ORPAeJFcSCu
         xSp5HahN9RKAn5wop7MB5n3RrGIJx6kqGn3kueffQLoiN+D9t7Tarvnibq1/zHBjkdw8
         bXG2T9xu5bpbrwOSZB4Cz58UN+2MIZ23QJdHTUVp/ATekiv3IC71g4IATJTnmulddCL3
         0kkQw0XpSjCshBCiNdWwQbe9Zfw8+YiURggemo1+mYR3QznfixdIOlUBVsqIeN5HW6vL
         2SmZuSuhOfIzbUFelE+7vbMMOAO2wVM8M2Dwy+tJznoJPMaPGBO1krgS43+NOhRPQ/pT
         iOMA==
X-Gm-Message-State: AOAM531tYkOQp4fnAEExplmx83xsPW6YngR8B8ZG43s3QP3kmM/g0yfZ
        h7tse461TLH80XomDizxqGi96tFZO0QqV2hWZJA=
X-Google-Smtp-Source: ABdhPJwZKwsiANsg+UcfYgpf9G8lRlY/XlXD48WbnKmE8u1o5TkbjgyLVxLDudYTFxaewl53ADYtcKRk2KXfxt3MJG0=
X-Received: by 2002:a6b:f816:: with SMTP id o22mr2692120ioh.106.1633604181530;
 Thu, 07 Oct 2021 03:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222502.645003-1-pauk.denis@gmail.com> <20211006222502.645003-4-pauk.denis@gmail.com>
In-Reply-To: <20211006222502.645003-4-pauk.denis@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 7 Oct 2021 12:56:09 +0200
Message-ID: <CAB95QASyv0MGiPGeu3ie7VSK_EjOR7x6kRsK57J5W-56dU0Nxw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hwmon: (asus_wmi_sensors) Support X370 Asus WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Denis,

On Thu, 7 Oct 2021 at 00:25, Denis Pauk <pauk.denis@gmail.com> wrote:

> +MODULE_AUTHOR("Eugene Shalygin <eugene.shalygin@gmail.com>");

No, I am not.

Best regards,
Eugene

P.S. You stripped module aliases for this one too. Why? This driver
certainly can benefit from them, because the presence of the specific
WMI UUIDs unambiguously defines its condition to work.
