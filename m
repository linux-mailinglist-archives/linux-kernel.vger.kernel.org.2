Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F32E3A35C1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFJVUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhFJVUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:20:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8483F61362;
        Thu, 10 Jun 2021 21:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623359895;
        bh=so8eXo9V+y7UW0kzOqL7D9DbbcWmGxu3kpYV0WhOpbs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XxfqYczG8QwvrY8aclg9g8W9rROovo/65gGEIPDu6ebReuz/5cMhF1AWPIVjHJAIf
         iJ3BIOxgP6Iu8OWz7FdO53fpWcGSO91yX+QWoEx1KkxyLnn2Z5roke4g5SDHyblGo9
         mjU/4NXXLmRxUMKdpH9BY/q2f7R/1rh38udM8WlQZy58BDO81olRVp+XtFkCMjN4QS
         JPqJ3GUWyQ1Lxg9YkZvNZWyKRr+zOk6h/YC6snjaKw7HpabO6ZJHmnx8bWwAhqkxX1
         4UhCt6F8SumFGEAfyMjW4ggcEyKeyBroECNAeqHEdYUYaGbT3aNrHaF/+eDN/zT8AG
         r7Aj/HxTJ0a+g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e9849007-8169-cb32-b0f1-5be6210f1319@geanix.com>
References: <20210610071758.1560592-1-sean@geanix.com> <e9849007-8169-cb32-b0f1-5be6210f1319@geanix.com>
Subject: Re: [PATCH] clk: fix possible circular locking in clk_notifier_register()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Sean Nyekjaer <sean@geanix.com>
Date:   Thu, 10 Jun 2021 14:18:14 -0700
Message-ID: <162335989440.9598.5831025849742947247@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sean Nyekjaer (2021-06-10 00:23:30)
> On 10/06/2021 09.17, Sean Nyekjaer wrote:
> > Allocating memory with prepare_lock mutex held makes lockdep unhappy
> > when memory pressure makes the system do fs_reclaim on eg. rawnand using
> > clk.
> >=20
> > Push the allocation outside the lock.
> >=20
> [...]
> >=20
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Fixes: b2476490ef111 ("clk: introduce the common clock framework")
>=20
> We could possibly add this fixes tag ^^

Sure.
