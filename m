Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E0E3E1F76
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 01:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbhHEXnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 19:43:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232947AbhHEXnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 19:43:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B78E60EB2;
        Thu,  5 Aug 2021 23:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628207009;
        bh=w58TtpXdxVQMYcRjot/BTYZO8pkrGjEZNh6L8v/2WJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UUEFGevNi4F2G3B4NIJgheM9l/OAOY0gd/py6oIf/SWsV8tgl4PzfzPSBMx6gOZI8
         7qz9Ef5dsFPMWsPSJQGp/CCRfEl11Cz4Dsw3ObmnM7VuvgICFQBVV58+f/5WnLgvvG
         t/92P0lMnP8sPctnLn0gRaAq3Kj8LU/PJtWY2nzM=
Date:   Thu, 5 Aug 2021 16:43:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     chenguanyou <chenguanyou9338@gmail.com>
Cc:     mhocko@suse.com, chenguanyou@xiaomi.com, gpiccoli@canonical.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, vbabka@suse.cz
Subject: Re: [PATCH v2] hungtask: add filter kthread
Message-Id: <20210805164328.58213d35e45d81c363b2135e@linux-foundation.org>
In-Reply-To: <20210805144720.30358-1-chenguanyou@xiaomi.com>
References: <YQvxf0KqvlVSO+R5@dhcp22.suse.cz>
        <20210805144720.30358-1-chenguanyou@xiaomi.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Aug 2021 22:47:20 +0800 chenguanyou <chenguanyou9338@gmail.com> wrote:

> > Either those kernel threads should be fixed to use less sleep or
> > annotate the sleep properly (TASK_IDLE).
> 
> The API for debugging when we no need care kernel threads state.
> 

Please explain this point in more detail?
