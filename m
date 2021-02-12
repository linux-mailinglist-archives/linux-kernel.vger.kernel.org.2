Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95A0319C72
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhBLKOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:14:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhBLKON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:14:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA80764E6B
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 10:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613124813;
        bh=BL++LHPR8QuAcZzU2B2MSIuBE35GyXKjJXTKMy0GziE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=knJpxuIiBAWAkoXHOwePeRMi472ozyKImtJVXynZMfUwpk+RVU1y5C7zv7+eH68qM
         ihC7SMYDud+K8MlrQUZWIcjq/vxbq8V0w1DUqIO7XvNQ8JLT9Mh2d2Lf4CbLN+bFtG
         9irLy47+3+e5Rk1S0oj3nS331GzCm+CCdTLojwQXmSHFtxRCyFKFJALxLmoar2N4SE
         0OE2B+zXGN9jaOv5dRyGuJqZlIJne81lWYqUaLxdVLAF2LpFd1FGdmksmrQNnWwqH3
         T/idktb606lPoesHhWRLSUOcBRclq1IdYpdkmlS6scQ/5+6sYoehmaBfaXj37fjNet
         iS0eyL7rsg1WQ==
Received: by mail-ot1-f44.google.com with SMTP id q4so7899289otm.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 02:13:32 -0800 (PST)
X-Gm-Message-State: AOAM532qhr9WyRQjABPs2jKofbpjdhD9WRDVDId1GAIV2t8t3/kxrKDp
        G0bmdMVUHINMdc7uRhNGhHPxJxG/4nYx5yfhshM=
X-Google-Smtp-Source: ABdhPJyK2E5+yQp93NPQYGaviroofQ81hvdu98R7oosLW6B36CMH5I1wxr/DQZxwh7pRhu4Y9dnwBoUI7FoWe2nJ/rk=
X-Received: by 2002:a9d:3403:: with SMTP id v3mr1473329otb.305.1613124812190;
 Fri, 12 Feb 2021 02:13:32 -0800 (PST)
MIME-Version: 1.0
References: <1613121426-15585-1-git-send-email-mihai.carabas@oracle.com> <1613121426-15585-4-git-send-email-mihai.carabas@oracle.com>
In-Reply-To: <1613121426-15585-4-git-send-email-mihai.carabas@oracle.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 12 Feb 2021 11:13:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0yTvk=wKVA84PYZhVsijrpjPBfEcicE8cn3VYGqbUj=A@mail.gmail.com>
Message-ID: <CAK8P3a0yTvk=wKVA84PYZhVsijrpjPBfEcicE8cn3VYGqbUj=A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] misc/pvpanic: add license
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 10:17 AM Mihai Carabas <mihai.carabas@oracle.com> wrote:
>
> Add license to the newly created files in adding support for pvpanic PCI device
> driver.
>
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>

I don't see why this is a separate patch, rather than part of the patch
that creates these files.

        Arnd
