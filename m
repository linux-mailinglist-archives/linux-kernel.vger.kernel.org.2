Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB32F3F41DA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 00:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhHVWEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 18:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhHVWEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 18:04:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93B8461212;
        Sun, 22 Aug 2021 22:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629669837;
        bh=8K/beN/2nbuexWDmJ7S10Egm6so7IejLRD+ADToiAsY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HU0hCwW4rpV6PcJL4BSRK/jJ3IPCgGIsZVtFUdL8h973hQ2KobGdJCbVzIcGIOLBp
         8oT3XEyN7N3GfBinKAojCsvfiCwmD6fDTC/HqkLgPoEwzw+1LoBayI85DiJGymJynF
         zqdywhhyNXxuOIS4+tiPXwH6rAMIgowDUA1mG4fQ=
Date:   Sun, 22 Aug 2021 15:03:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: Improve GIT_COMMIT_ID test
Message-Id: <20210822150354.3c0dcb7d7e8fefaa856383e5@linux-foundation.org>
In-Reply-To: <976c6cdd680db4b55ae31b5fc2d1779da5c0dc66.camel@perches.com>
References: <976c6cdd680db4b55ae31b5fc2d1779da5c0dc66.camel@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 14:46:51 -0700 Joe Perches <joe@perches.com> wrote:

> +		if ($perl_version_ok
> +		    $in_commit_log && !$commit_log_possible_stack_dump &&

Needs &&.   Was the correct version sent?
