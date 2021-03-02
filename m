Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABFC32A583
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350797AbhCBMtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:49:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:40188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383849AbhCBMLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:11:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F58AAF44;
        Tue,  2 Mar 2021 12:09:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 74266DA8BB; Tue,  2 Mar 2021 13:07:08 +0100 (CET)
Date:   Tue, 2 Mar 2021 13:07:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: turn btrfs_destroy_all_ordered_extents() into
 void functions
Message-ID: <20210302120708.GH7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Yang Li <yang.lee@linux.alibaba.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1614675476-79534-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614675476-79534-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 04:57:56PM +0800, Yang Li wrote:
> These functions always return '0' and no callers use the return
> value. So make it a void function.

The reasoning needs to go the other way around: you can make a function
return void iff all callees also return void and don't do BUG_ON instead
of proper error handling.

Which in this case does not hold, because the function itself still does
BUG_ON.

> It fixes the following warning detected by coccinelle:
> ./fs/btrfs/disk-io.c:4522:5-8: Unneeded variable: "ret". Return "0" on
> line 4530

Yeah tools can identify the simple cases but fixing that properly needs
to extend to the whole callgraph and understand all the contexts where
local data are undone and errors propagated up the callchanin.
