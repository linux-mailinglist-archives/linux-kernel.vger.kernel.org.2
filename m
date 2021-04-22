Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4370367614
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 02:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343841AbhDVAKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 20:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhDVAKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:10:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC9CA61445;
        Thu, 22 Apr 2021 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619050214;
        bh=iRniVZ7sjUtxxs5WaUACnqm1vLQ6x03AitU/+8yfCaE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=adtuGHyHyENq3Yc7JOdaH3ZN+rZsgjRepO1piVBdvEzBkH/4LYqPq+B0fmlqq2kUQ
         G/P5xEhh9nHpcrgvBfEAxF9iqFnbfhV8MTDEJUnUYPk310rx6lxYVEOmGY7l3W1oH9
         EiCbhMLhOXJXvdHfUS8nIL1jGMI1ij8J+sOxTAApcToY9RooQ4HcdgV2c9k0xykidu
         CJQcSWIL4cKMcEpfXnVaPlPJXfWKSKEeTk+qcmIwgci9FzrU5mTOs9TrRTQucUj05M
         z43HMmKggrAg6M5MGI6aPZEZzjJheVu3s/Y2zDOj2NXMA6fUrqnNL239CQsQXy/EJb
         RtejK5iUYjqag==
Date:   Wed, 21 Apr 2021 17:10:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tariq Toukan <tariqt@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 046/190] Revert "net/mlx4_core: fix a memory leak bug."
Message-ID: <20210421171012.2f838a42@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Reply-To: 20210421130105.1226686-1-gregkh@linuxfoundation.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(replying from the archive)

> This reverts commit febfd9d3c7f74063e8e630b15413ca91b567f963.

CCing Tariq on this one, unless there is some deep magic this one looks
okay, too.
