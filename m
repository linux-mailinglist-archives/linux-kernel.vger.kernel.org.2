Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F954294BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhJKQuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 12:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhJKQuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 12:50:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1738CC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 09:48:08 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w6so3772193pfd.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jvHl7wRT0k8FApT63DElqTJJPL+rrhBfM7ZcKREF6pQ=;
        b=Q4uQSHpbjGxj9FawQzyKNKB0eJJBumdjLslNm7euBr2fDU7nwuQs+tX1mftPhpOSJd
         jJ0vrA45swQHK0Q7QoLTAFrDiKOGFyScWCRPEehNw4wn0RwJDU5+r8p512RJXk5LXnYL
         L3f+Y6TBJFL5nzLyXX7/8OHWr/EytTuTW7s93x+yDKTewM6huDtEe+dbscSQhm2oEKnS
         Ul9A+V8+tzWiWcFEnFPKG1Pe5o6cBJp51uywXxn7nDeqFnMcWb7QVGykmKdmE6sSNulC
         M6BvujBP62+jCiu8J373i5oDhi+/8tE9Ckt5lWV/Hn0CauhIEbO4jxqCUlO9jHs49x91
         qkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jvHl7wRT0k8FApT63DElqTJJPL+rrhBfM7ZcKREF6pQ=;
        b=w+Ac5xHux5wKgD+yCHzMNN2FW5M4J1PHgwHgiBlV3zRKTv65338sQ7J2QJBjQ03ATF
         ve9BalL+Z43k5yjF7FAp8e36ZbjJOSUbcmYY8IMaRUD6jK5Jod3LtAfkBVCJ5hMMYEhN
         9Xx33K0wFm2KVXXkXt/gU5EoiTb92pCLE8FnnxtoOKylyZapEHK+vfRdOBfc4Hu30zNW
         DDGgEM2sW9xsbyjDGp8xV6++rqX2Z4N0ahqFyXtJwWzpFSHAEMQZsye0PBfRkkciGXRC
         mEsjw2xx9jxCAG4LOBppPs017AxNfFqEJQWthT6ZJ/BpB6eD6goCciuCzotAGuEIdalF
         ydZg==
X-Gm-Message-State: AOAM531fd560KGOmBsR4H7tkGHhFLUAm4/Q7nJ3WxAltWZXqaUNPajxX
        cDtcUIV/xWeOs6n8jdetHZ/zZDnSrDaAdg==
X-Google-Smtp-Source: ABdhPJyLOTrK/K6M305xoUJRoRyD5lwI3O49TXy+NRYL2orYrCkfgqI4ZOEb2bGpw6Pqr6Sw2oMirg==
X-Received: by 2002:a63:4c7:: with SMTP id 190mr18890821pge.366.1633970887322;
        Mon, 11 Oct 2021 09:48:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id j9sm8639864pgn.68.2021.10.11.09.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:48:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 11 Oct 2021 06:48:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] workqueue: Introduce __show_worker_pool_state and
 __show_workqueue_state.
Message-ID: <YWRqxS4IMVW4ZCN/@slm.duckdns.org>
References: <20211005213841.736834-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005213841.736834-1-imran.f.khan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 08:38:41AM +1100, Imran Khan wrote:
> So divide show_workqueue_state into more granular functions
> (__show_workqueue_state and __show_worker_pool_state), that would show

This is nit-picky but can we please name them sth like
show_one_workqueue_state() and show_one_worker_pool_state() or just
show_one_workqueue() and show_one_worker_pool() with the corresponding
versions renamed to show_all_workqueues() and show_all_worker_pools()?

Thanks.

-- 
tejun
