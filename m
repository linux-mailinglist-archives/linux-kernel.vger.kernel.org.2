Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ECD415F39
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241041AbhIWNKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:10:44 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:42488 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232333AbhIWNKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:10:43 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 18ND99Uu019984;
        Thu, 23 Sep 2021 15:09:09 +0200
Date:   Thu, 23 Sep 2021 15:09:09 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ken <kennethcelander@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Boot opens CD tray
Message-ID: <20210923130909.GB19709@1wt.eu>
Reply-To: linux-kernel@vger.kernel.org
References: <bbb0df1d-1e40-fbdf-d9aa-281ba77b4b6d@gmail.com>
 <20210923123407.GA19709@1wt.eu>
 <3e2fe30b-4c58-3164-2e2f-283f34ebe396@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e2fe30b-4c58-3164-2e2f-283f34ebe396@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 08:03:49AM -0500, Ken wrote:
> The CD/DVD is a SATA ASUS; connected to a ASRock 970A-G/3.1 motherboard.
> 
> The changed "driver" has to be in the kernel, if it changed.

Sure but I mean that it will help narrow the problem to some subsystems.
Unfortunately we don't know what patches your distro kernel applied between
the two versions, but if you can figure that out from their changelogs, it
may help you narrow this down to just a few patches. These ones would
typically have "ata" in their subject line (sometimes "sata" or "libata"),
that could significantly limit the number of possible candidates. If you
can't find this there, you'll have two possibilities left:
  - either retry with an official kernel from kernel.org
  - or report a bug to your distro

Willy
