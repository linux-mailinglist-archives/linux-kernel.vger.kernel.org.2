Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9835EFAE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349893AbhDNIcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230373AbhDNIcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:32:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B527C61027;
        Wed, 14 Apr 2021 08:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618389110;
        bh=UqnrkAY5MJVDS6ANSGLwQ1hvxAhnqyVqlb1wgCE9y8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yeS7dj4eSk4apT2HzoxUc+pbEYrUvjYMSx3dzWyn8TsEyjqWQ4pU1pvvfCc0eHGCj
         aeUm/eK9RmiZXvYHAJM++d9wKTD5hVCAYWusRYbAPzjf88060nqJA/W33HfRvkPtlZ
         TsQy0WudHHFJyEebu07vQ9EGlSLri54T18y0IDgQ=
Date:   Wed, 14 Apr 2021 10:31:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH v6 1/2] staging: rtl8192e: remove parentheses around
 boolean expression
Message-ID: <YHaoc3N2fidI0TQ6@kroah.com>
References: <cover.1618383684.git.mitaliborkar810@gmail.com>
 <60483f646c16ffd3c19ca8f508a1f1c3a0a13db6.1618383684.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60483f646c16ffd3c19ca8f508a1f1c3a0a13db6.1618383684.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 12:51:55PM +0530, Mitali Borkar wrote:
> Removed unnecessary parentheses around '!xyz' boolean expression as '!'
> has higher precedance than '||'
> 
> Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> ---

This series does not apply to my tree :(
