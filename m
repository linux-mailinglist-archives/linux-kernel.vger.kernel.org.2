Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC1F443EBF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhKCI65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:58:57 -0400
Received: from mail.gnudd.com ([93.91.132.248]:34667 "EHLO mail.gnudd.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231939AbhKCI6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:58:55 -0400
X-Greylist: delayed 778 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Nov 2021 04:58:54 EDT
Received: from mail.gnudd.com (localhost [127.0.0.1])
        by mail.gnudd.com (8.14.4/8.14.4/Debian-4+deb7u1) with ESMTP id 1A38hFuo024798;
        Wed, 3 Nov 2021 09:43:15 +0100
Received: (from rubini@localhost)
        by mail.gnudd.com (8.14.4/8.14.4/Submit) id 1A38hETw024797;
        Wed, 3 Nov 2021 09:43:14 +0100
Date:   Wed, 3 Nov 2021 09:43:14 +0100
From:   Alessandro Rubini <rubini@gnudd.com>
To:     corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH 4/9] Remove unused header <linux/sdb.h>
Message-ID: <20211103084314.GA24790@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GnuDD, Device Drivers, Embedded Systems, Courses
Sender: rubini@gnudd.com
In-Reply-To: <20211102220203.940290-5-corbet@lwn.net>
References: <20211102220203.940290-5-corbet@lwn.net>
  <20211102220203.940290-1-corbet@lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Commit 6a80b30086b8 ("fmc: Delete the FMC subsystem") removed the last user
> of <linux/sdb.h>, but left the header file behind.  Nothing uses this file,
> delete it now.

Acked-by: Alessandro Rubini <rubini@gnudd.com>

thanks
/alessandro
