Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A61044F367
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 14:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhKMNlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 08:41:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:50374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhKMNlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 08:41:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E29361073;
        Sat, 13 Nov 2021 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636810706;
        bh=Qn+vg24tCnpAkIyiaQnUebCpLrWWTisLgtwoHrOJzxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ku6KTgBEkJWAAAfTM8zAQXQKQVp7fPOskfXGHank59FuNad6glXH4fMwg71wxH+Jg
         3UdH614OwRZf88ImjzZWuV3no1U4z96cAMMfjJ+axLqMUKAkLosIFjcehkp0bnWuwm
         SP+uKdvvQpk0q4b5DrxS1pNP8n36f3uNKN/LsvHEWsbpDObs95ShUtlYa/K22mWQwi
         2OUfqmTfwjYaOqZFvlyPykjybI4zZylqZUW0hl/X0yq+NCCc5I0yX4FqDWMfnGRrWE
         zmdI4lu1G2Ry+z0ieASJeZZsA7Ev9ZP/KLf20D9+D4XzOs7ti3iICwNn0EMntfBFu7
         yBrw722ON/f3g==
Date:   Sat, 13 Nov 2021 08:38:25 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     linux-kernel@vger.kernel.org, bvanassche@acm.org,
        gregkh@linuxfoundation.org
Subject: Re: Is tools/lib/lockdep dead?
Message-ID: <YY+/0VqcJCvBSu34@sashalap>
References: <20211109195307.532354f9@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211109195307.532354f9@hermes.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 07:53:07PM -0800, Stephen Hemminger wrote:
>Tried building tools/lib/lockdep and it appears to be unbuildable
>for quite a while.
>
>   - last real commit was in 2019
>
>   - still has Sasha's old email in MAINTAINERS

Yup, and now it's officially gone.

-- 
Thanks,
Sasha
