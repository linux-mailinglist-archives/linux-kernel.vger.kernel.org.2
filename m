Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED9F4047DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhIIJh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:37:28 -0400
Received: from 8bytes.org ([81.169.241.247]:53234 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232860AbhIIJh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:37:26 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 724C060F; Thu,  9 Sep 2021 11:36:15 +0200 (CEST)
Date:   Thu, 9 Sep 2021 11:36:09 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jon.Grimm@amd.com, wei.huang2@amd.com
Subject: Re: [PATCH 0/3] iommu/amd: Fix unable to handle page fault due to
 AVIC
Message-ID: <YTnViaK3uRNSGK8Q@8bytes.org>
References: <20210820202957.187572-1-suravee.suthikulpanit@amd.com>
 <f2ec4e5c-3bb1-b703-8842-34357e084bad@amd.com>
 <YTB/jWr9vb6xvTQp@8bytes.org>
 <5c7921f4-70ad-5d14-f44c-22a49c2ac068@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7921f4-70ad-5d14-f44c-22a49c2ac068@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On Thu, Sep 02, 2021 at 09:13:00AM -0700, Suthikulpanit, Suravee wrote:
> I'll do that.

New plan: I queued them now and added the Fixes tag. Will send a
pull-request tomorrow to get them upstream together with a couple of
other fixes.

Regards,

	Joerg
