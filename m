Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9E03762DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbhEGJbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhEGJbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:31:32 -0400
X-Greylist: delayed 474 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 May 2021 02:30:32 PDT
Received: from mail.schwarzvogel.de (mail.schwarzvogel.de [IPv6:2a01:4f8:173:2c8b::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764EBC061574;
        Fri,  7 May 2021 02:30:32 -0700 (PDT)
Received: from klausman by mail.schwarzvogel.de with local (Exim 4.94.2)
        (envelope-from <klausman@schwarzvogel.de>)
        id 1lewgt-000Csv-Pv; Fri, 07 May 2021 11:22:35 +0200
Date:   Fri, 7 May 2021 11:22:35 +0200
From:   Tobias Klausmann <klausman@schwarzvogel.de>
To:     linux-alpha@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Concern about arch/alpha/kernel/smc37c669.c
Message-ID: <YJUG2wovDYZQpJ9R@skade.schwarzvogel.de>
Mail-Followup-To: linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <7b314145-cbb9-b491-ccf5-d6021a574339@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b314145-cbb9-b491-ccf5-d6021a574339@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! 

On Fri, 07 May 2021, He Zhe wrote:
> There is no "SPDX-License-Identifier: GPL-2.0" in arch/alpha/kernel/smc37c669.c
> and the following copyright is found.
> "
> Copyright (C) 1997 by
> Digital Equipment Corporation, Maynard, Massachusetts.
> All rights reserved.
> "

That file is ancient (I reckon it's at least two decades old) and
looks like a wholesale include of a DEC/Digital .h file for that
particular chip. Since we didn't have DCOs or anything like that
back then, I am unsure what the license (if any) actually is.

It's even difficult to figure out when (and by who) it was first
committed. The oldest reference in a grafted-together git repo I
could find was from 2.1.88. 

Best,
Tobias

-- 
/* panic??  These should never occur in our application. */
        linux-2.6.6/drivers/scsi/aic7xxx/aiclib.c
