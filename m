Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260CE38B984
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 00:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhETWfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 18:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231524AbhETWfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 18:35:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F3496023E;
        Thu, 20 May 2021 22:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621550068;
        bh=bi67eiUs2fRyrrcl+E/qaSEXxD87m6VWYQHCV09Rfb4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aeEJdvugsnTlOrk2ecc7BAKi4yTCN12scA2qQHetYcX6hpNYOCDbrQHkEw6C5fy1G
         vYS1qJ0+CIfFjzC/zW0cOQKBhS3MHv48FXOcF8OOjWFWv+JG15xy3SUlCGJ88xAron
         D3bQB3UfBj3A0EVT2hnBW5f2pPaANaewvbjGaFVQ=
Date:   Thu, 20 May 2021 15:34:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        snu@amazon.de, vbabka@suse.cz, vdavydov.dev@gmail.com,
        zgf574564920@gmail.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v29 00/13] Introduce Data Access MONitor (DAMON)
Message-Id: <20210520153426.34bfe5ab64ca1f06cca6f231@linux-foundation.org>
In-Reply-To: <20210520075629.4332-1-sj38.park@gmail.com>
References: <20210520075629.4332-1-sj38.park@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 07:56:16 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> Changes from Previous Version (v28)

Thanks for persisting with this.

I'd be interested in people's overall take on this work, please. 
Mainly a high-level "should we merge this" view.  Detailed review of
implementation and interface details can follow on in the usual fashion.
