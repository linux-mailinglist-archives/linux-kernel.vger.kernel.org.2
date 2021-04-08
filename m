Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE2357DBD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhDHIA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:00:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhDHIA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:00:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04A2B6113D;
        Thu,  8 Apr 2021 08:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617868845;
        bh=5feZWCmUqFMfNFqnz13xTcDntlaU3T5HOPga2qriT8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rpKEMNf7LmAtxXpAo7IkN/7xToOFP1RZs7lk5id+muAmO5HWnvFBrtiux5c86t4wC
         nA5y9Vq/eEbvtK/LbeR0WZqr20OZ0D+SAkrFDWYaiIRCb6T8i0LUAwXJ8Bc2UDe2eF
         52PQbRXLFvPdZHx/dHg8/RBbZ9rrQo3yEryyOHtI=
Date:   Thu, 8 Apr 2021 10:00:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH] staging: rtl8712: removed unnecessary blank line
Message-ID: <YG64Kvun5Xxy4lOL@kroah.com>
References: <YG61JYTdl1HQKcGj@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG61JYTdl1HQKcGj@kali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 01:17:49PM +0530, Mitali Borkar wrote:
> Cleanup patch for CHECK: blank lines aren't necessary after an open
> brace '{'
> Reported by checkpatch

But you did more than just the above in this patch, which is not ok :(
