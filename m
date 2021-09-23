Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141DB415E72
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbhIWMfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:35:42 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:42484 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232201AbhIWMfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:35:41 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 18NCY70h019792;
        Thu, 23 Sep 2021 14:34:07 +0200
Date:   Thu, 23 Sep 2021 14:34:07 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ken <kennethcelander@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Boot opens CD tray
Message-ID: <20210923123407.GA19709@1wt.eu>
Reply-To: linux-kernel@vger.kernel.org
References: <bbb0df1d-1e40-fbdf-d9aa-281ba77b4b6d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbb0df1d-1e40-fbdf-d9aa-281ba77b4b6d@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 07:27:48AM -0500, Ken wrote:
> Linux Mint 20.2.
> 
> Near the end of the boot up process, the CD/DVD tray will open, and
> immediately close.
> 
> This started with the kernel update 5.4.0-84.94, and now also with
> 5.4.0-86.97.
> 
> Time shifted back to 5.4.0-81, with no CD tray opening problem.

I guess you should at least provide more info such as how your CD drive
is attached to the host (SATA/USB/IDE/SCSI/other?), and maybe compare
the boot logs from the working and broken kernels just in case you'd
find different messages possibly indicating a difference in a driver.

Willy
