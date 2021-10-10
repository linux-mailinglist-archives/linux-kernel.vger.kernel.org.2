Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C3F42819D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhJJN4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 09:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232814AbhJJN4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 09:56:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AC8F60EE7;
        Sun, 10 Oct 2021 13:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633874094;
        bh=/lt7hCTo+SQbmtc0aeh/KIz1iT8tkUMtuxhR6dilzjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boKKg0VFNS71gjIsSnCTGf/z8fEzxUfl83KFLsyx22jtHm7wwCJ3fYj28+e3b4Su/
         41y/svGC/6aBLW2fTZswZwgXKValxfWXRHLTCvugqzyaAoKghdzuXSHaNM84QMF/Ng
         PYbdaPS79mwogMAnnpvRzV5Ql4zYqD1zNQ0IAva5XKWYDC9HugeUxaIrtZ1WdkXjMx
         pTjuynBAzY6QGj+4PnmMMMAvd4IWhCuS6GX3cc16sXh+mzEUolUo1Br/XgsOmx0/i8
         +xRJJJ5dDcfCpi8PgqZ6ALdNRtNRNbXANgnFYsZTTev6UQbGFzi4FoxUHZA4se/pMu
         4T/RJKWqCJnPw==
Received: by pali.im (Postfix)
        id 9E6D1795; Sun, 10 Oct 2021 15:54:51 +0200 (CEST)
Date:   Sun, 10 Oct 2021 15:54:51 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Update ASUS WMI supported boards
Message-ID: <20211010135451.aadvcebestbnzhru@pali>
References: <20211010095216.25115-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010095216.25115-1-pauk.denis@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 October 2021 12:52:13 Denis Pauk wrote:
> Add support by WMI interface privided by Asus for B550/X570 boards: 
...
> Add support by WMI interface privided by Asus for X370/X470/
> B450/X399 boards:
...
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807

Hello! Could you provide (at least into bug tracker) MOF definitions of
WMI functions? If there are are any issues with driver, definitions of
API, functions and buffers could help.
