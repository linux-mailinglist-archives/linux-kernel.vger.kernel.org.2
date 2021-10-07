Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0650425B2D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbhJGSyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233866AbhJGSyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:54:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80C39610CC;
        Thu,  7 Oct 2021 18:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633632757;
        bh=Vn3rKobGYs8to3CWRbzuyabBAqO9oqlqvTLkLsUXEvY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l+xXnl/pbMJ3x6PtZqxR7qf/ZI3uPfCHvfKxYrZEJZJCZx8WxPXQjdxLpjOYxTUH3
         UuhB0emx5lt4FBtc5Xp1NhpheezzrqruZgs0ILQk85rJRJ4eSgNcedR2wU6mQgyArs
         GJh7epNQ+nn+oA/cJIQib2ktMQ8cU7VWuVHwDdRE=
Date:   Thu, 7 Oct 2021 11:52:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     christian.brauner@ubuntu.com, ebiederm@xmission.com,
        fweimer@redhat.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: test that /proc/*/task doesn't contain "0"
Message-Id: <20211007115237.15ae4ba27b4ca4e21094852d@linux-foundation.org>
In-Reply-To: <YV88AnVzHxPafQ9o@localhost.localdomain>
References: <20210929232038.o0_ct-q8J%akpm@linux-foundation.org>
        <YV88AnVzHxPafQ9o@localhost.localdomain>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 21:27:14 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

Could we please have a changelog :(

Why are we doing this?
