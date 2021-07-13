Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575D63C6ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 08:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhGMHC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232908AbhGMHCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:02:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9845061003;
        Tue, 13 Jul 2021 06:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626159575;
        bh=CPoAqfXqh8v6lEBrf+dIf4GacQFoWE+iH27rViLAOF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dRhkhyxH47WeNXn9m4VC3AeFPtf885Orea1TK/PqLxrPYWnfjGY8YR9PtQEJ4ZbPO
         2sWEi2/Gl8+l8J6ZiJLiSJRQSd9Ym6ReJYZhqQcXx5q66u6cq+YxeELKx+uMkLJKh6
         q3tUoL6D4/2XcJ5y2mjZvCxv111X/ikyDp3GTo4k=
Date:   Tue, 13 Jul 2021 08:59:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     pandith.n@intel.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, furong.zhou@intel.com,
        mgross@linux.intel.com, mallikarjunappa.sangannavar@intel.com,
        andriy.shevchenko@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH V5 1/1] misc: NOC Probe Counters
Message-ID: <YO051OOCA5A2QG/K@kroah.com>
References: <20210713065347.21554-1-pandith.n@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713065347.21554-1-pandith.n@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 12:23:47PM +0530, pandith.n@intel.com wrote:
> +#define NOC_MAGIC 'n'
> +#define NOC_SETUP                _IOW(NOC_MAGIC, 1, void*)
> +#define NOC_PROBE_START          _IOW(NOC_MAGIC, 2, void*)
> +#define NOC_COUNTER_CAPTURE      _IOW(NOC_MAGIC, 3, void*)

This was obviously not reviewed by Mark, otherwise he would have noticed
how wrong this was :(

{sigh}

greg k-h
