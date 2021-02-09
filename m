Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA9C315210
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhBIOvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:51:50 -0500
Received: from mail.efficios.com ([167.114.26.124]:58408 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhBIOvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:51:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D914B2E0CA2;
        Tue,  9 Feb 2021 09:50:57 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Bl8gqbEvz6jb; Tue,  9 Feb 2021 09:50:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9562E2E01FA;
        Tue,  9 Feb 2021 09:50:57 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9562E2E01FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1612882257;
        bh=n/W0V/uTePGxEiIgd01XpqyfbViCZ4URv94DHX9uY5s=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=goE4h23nLiLvdCFQLUiCgYNBGQLW9pWqIUPS0siiaiShntrZ+0m3q9UxZrs8vaPcI
         qPoH6DiX1bFIixtLWIvFp4R4MIw1uLiXAi1VEiVnIjAewhEeJ2Lt9eSpOwd1KpajRZ
         T0bOclKBi2j4QsbO8ZTBtswaHnQB1gnrlAuUvMTIsacp0Sca3SKTD4yiDtmCqIgjg/
         8JaulWLmrY+ukQRGPpnKcTnDLJb5xJXPI54GcuRvTdh5FNO1YfacD2lLnCUMpjxgtP
         Qu7eLKyB1we1U911ENKgSvE8KO+x92EmIJo7OGQ+UrudNGiil2ai2et4lqIwlPB09Y
         6StY7IntGrJPQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o5cdKsUnwHFy; Tue,  9 Feb 2021 09:50:57 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 88DB92E0960;
        Tue,  9 Feb 2021 09:50:57 -0500 (EST)
Date:   Tue, 9 Feb 2021 09:50:57 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <568224295.11215.1612882257457.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210208200922.215867530@goodmis.org>
References: <20210208200922.215867530@goodmis.org>
Subject: Re: [PATCH 0/2 v3] tracepoints: Stop punishing non-static call
 users
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Topic: tracepoints: Stop punishing non-static call users
Thread-Index: CgpPX12m8sJ1tYL5M1Ec7nOH23IAfw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 8, 2021, at 3:09 PM, rostedt rostedt@goodmis.org wrote:

> Broke this up into two patches now. See the second patch for the
> description of waht this series is doing.

For both patches:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Changes since v2:
> 
> Added a patch to remove "data_args", as it was causing issues with
> handling of "__data", especially when it wasn't needed.
> 
> 
> Steven Rostedt (VMware) (2):
>      tracepoints: Remove unnecessary "data_args" macro parameter
>      tracepoints: Do not punish non static call users
> 
> ----
> include/linux/tracepoint.h | 52 ++++++++++++++++++++--------------------------
>  1 file changed, 23 insertions(+), 29 deletions(-)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
