Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABF136C7F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbhD0Otc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236226AbhD0Otb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:49:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE5D861151;
        Tue, 27 Apr 2021 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619534927;
        bh=4U5czcVnw4ntcb9tNH5bPmIU9DevlCapw0JEz5zc0u4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UE0H1AFn0BAI2HJT68Vgev6ghNUNRqUMv66m8jZsNmR4vOkjltzYDoupSWnv0GeXv
         23wRGDAA6vzc6cJJeKqqit8p0wr7MW5CikVPqFEI72rdx7YQN9Dfv33e0m6alhnxKy
         JdsT5dY22u6v33agWRL4xLjSjpbxr/+41OUvwtkI=
Date:   Tue, 27 Apr 2021 16:48:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 065/190] Revert "nfsd: remove unnecessary assertion in
 nfsd4_encode_replay"
Message-ID: <YIgkTNRlfp/zDYt6@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-66-gregkh@linuxfoundation.org>
 <YIA3lhTMV2Ib1KLx@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIA3lhTMV2Ib1KLx@pick.fieldses.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:32:54AM -0400, J. Bruce Fields wrote:
> This patch was fine, NAK to the revert.

Thanks for the review, I have dropped the revert from my tree.

greg k-h
