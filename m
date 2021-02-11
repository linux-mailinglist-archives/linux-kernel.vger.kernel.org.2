Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6D93185BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 08:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhBKHfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 02:35:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhBKHfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 02:35:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 207C864E7D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 07:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613028891;
        bh=4/Q0VnNs4sKzkFI04qi22J3s6PluFlNSVcxbDjnWrU0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cWR5RZSLs3QKr/VFdL4X7zQ9EWerNxrB1V0POdPmfWFCd+BGmdYxdnv3XTV+SZ2eI
         2UxKO/3Hr21VLDehmdxY8y0k6fTsgL0rRBrckdfdw9JxEVlOEoRABA4fcn3kqf6o3O
         jUrjTnTVtBt+SkmqBrcBuCjgTcQhhBwP53Y36W556Py09xLDf1E6GhOAJrZ3BqOEl8
         tTre3tsUYGvdZNnTXSNcrpml73Ysa5L9X1/zdPobbRW/1cBBW1lUdTmzZduNrh7JWh
         s5T0hGrnSzA/LNSuVYEy/Z7O8U8Lu97aO7ZBjLJ0aCwUuuzi7xf/DOHxhcGgygODK3
         gEoJU4YIA3MRA==
Received: by mail-oi1-f175.google.com with SMTP id h6so5109514oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 23:34:51 -0800 (PST)
X-Gm-Message-State: AOAM532AdfRjNEbxZdzPIEWkxC5M4XNN/o3Z1TGL/Xz/gzNyda7qNBk3
        oWlWmkQFr/fONU0BpmqHXDx0NRz9Su90YModZVg=
X-Google-Smtp-Source: ABdhPJxFdVgzxxSHL4iu3EVGMx4yOsV6qiz70Cj2/1JBqW+f1YCUl6kjWkVWtdif/tPp9xl+JGpD0xaUTIqszAX9mCM=
X-Received: by 2002:aca:e103:: with SMTP id y3mr1816779oig.11.1613028890530;
 Wed, 10 Feb 2021 23:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20210210235243.398810-1-joel@jms.id.au>
In-Reply-To: <20210210235243.398810-1-joel@jms.id.au>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 11 Feb 2021 08:34:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1SMBhqjj=VQgxU6YoVT-c34YYvhFDiGHBSMyX9AhDNnw@mail.gmail.com>
Message-ID: <CAK8P3a1SMBhqjj=VQgxU6YoVT-c34YYvhFDiGHBSMyX9AhDNnw@mail.gmail.com>
Subject: Re: [PATCH] ARM: kexec: Remove unused kexec_reinit callback
To:     Joel Stanley <joel@jms.id.au>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 12:52 AM Joel Stanley <joel@jms.id.au> wrote:
>
> The last (only?) user of this was removed in commit ba364fc752da ("ARM:
> Kirkwood: Remove mach-kirkwood"), back in v3.17.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
