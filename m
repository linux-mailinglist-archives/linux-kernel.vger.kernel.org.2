Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC29335C2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241247AbhDLJsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238594AbhDLJfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:35:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81C4561245;
        Mon, 12 Apr 2021 09:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618220098;
        bh=Y1sxCfWweWwRbvZLgkMHw1bDp73dV7VYdbFVdmmmtZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqNT/d3q3utn3eCtUo+AWp7O5ZIu1JPCfGXQXXVDgvA2aU99E6Yr/AqIo+waPyj06
         UlyyECWQssAp17huOiKlVSG06T5Mbyy9CwTR6MnzgMlSKzMc9q5yrUdGuyyYmPD7xg
         mM/w2EwHmqdkgPtD9Q3XzFDbCPhv0dXBTIQD/a0Q=
Date:   Mon, 12 Apr 2021 11:34:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH v3 0/3] Modify subject description and rectify spelling
 mistake.
Message-ID: <YHQUP/zq1vGwram/@kroah.com>
References: <cover.1618133351.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618133351.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 03:25:05PM +0530, Mitali Borkar wrote:
> This patch fixes style issues

"this" is not a patch :(

And the subject line here also needs fixed up.

thanks,

greg k-h
