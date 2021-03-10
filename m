Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174ED3338C8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhCJJcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:32:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232289AbhCJJcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:32:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACC6C64FF2;
        Wed, 10 Mar 2021 09:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615368763;
        bh=XuUqYzN0S1TWPUlavxjWKpwjtiGA2Swm3zbnW9JOt4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plo9EBf3SBseNOoLY70uww5QQUNpQTNBsKE/Q+yEyrY9kGwg8i1at2PYYigupkGvR
         f+KqVA/ZddqS/qdOUe5kvxrD8ha9uWyr5w3H7w8W3+AulCUN/vJ9iqJOj5qzpBzjBv
         Wh4zZ7GUwPLe+Z2X6QkVuka0ad3ADU0ja4PSZcek=
Date:   Wed, 10 Mar 2021 10:32:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus/operation: Drop reference when message has been
 set
Message-ID: <YEiSOB05c0iyOFFj@kroah.com>
References: <20210310091014.6407-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310091014.6407-1-lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 01:10:14AM -0800, Lv Yunlong wrote:
> In gb_operation_response_send, get an extra reference
> before gb_message_send() with this comment "/* Reference will
> be dropped when message has been sent. */". Therefore, we
> should drop the got reference not only in the error branch,
> but also in the complete branch.

That's not what your patch does at all :(

