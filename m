Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634E0360A67
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhDONWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:22:35 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:51674 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDONWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:22:31 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 13FDLjse004228;
        Thu, 15 Apr 2021 15:21:45 +0200
Date:   Thu, 15 Apr 2021 15:21:45 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Colin King <colin.king@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Denis Efremov <efremov@linux.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] floppy: remove redundant assignment to variable st
Message-ID: <20210415132145.GD2791@1wt.eu>
References: <20210415130020.1959951-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415130020.1959951-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 02:00:20PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable st is being assigned a value that is never read and
> it is being updated later with a new value. The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Indeed you're right.

Acked-by: Willy Tarreau <w@1wt.eu>

Willy
