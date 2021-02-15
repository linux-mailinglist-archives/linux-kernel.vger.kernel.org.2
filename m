Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A4E31C472
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 00:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBOXkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 18:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBOXj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 18:39:58 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE58C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 15:39:17 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id v7so10993779wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 15:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=wLm2i2GvaWTl/hRu8jY+vx+lHt37QloeSrAVMMqCcO0=;
        b=Ir8t7o+QDy7omMHThZDg+FClc0XRjHGRsaSMsbZMmBckbb6KoxFBTCtTqCHnbH0aOw
         auwN1vLS+rzuF1lSbxAjqLt5cvV83XVP50sOIUmyV2MGODwjbpJfEFv04eK+UT0ggSto
         EeMJRdJLWWJCXBclMni++p8+eyS02jQ5Eg3ukmaUX0xa1Xt1HqYBO6GS+Tbw9foLZn23
         JNAX6wrkycQtdL59tkwYK+3ClijAN6Sqzt23+SWKgS2n3gQuuvjc7BbszNEDVY3797xR
         KaGhm+FvvQOHtG6KYXHCmOGms9+VGZjkmayHy/UPJA5WBaDvt2JH5Pym9spL+DFVsTv4
         Blpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=wLm2i2GvaWTl/hRu8jY+vx+lHt37QloeSrAVMMqCcO0=;
        b=d71m3gHTGHN4QvJl5MTBANfImN6naZe8MIsIPHkbVdqTslSNxUDWGAcXAALVO3UGqn
         ZlWnYABw/w0Wofa5eXiqVxQeF/ascyGzdl6hLheYBhSySJBRNzgvfBE616ckVUFpFo4h
         xBd3HiPqWIbRM/HXgZUmLk5SMP7hy3PaLnWynlUyL+1UB4GUBbwUS4+XZDNjLG65pf0X
         RE6uWd6CNJInlSrMjeOGW7A3mAxums6PR9Hb8H4fA7NYNpjWCjXgUgdWQQdT71wRhHBQ
         eKEJH82lO7n7GXupR7n79ojsVYuw+YyIYyNeMq6x3llYpJx39zk2t7TZwNkHynVIFKo4
         Q2RQ==
X-Gm-Message-State: AOAM532Uk8VxQaQdH1xLb/6wvLxbMzJLQUETb7IpzTxd89XAzG3+Zbpc
        1K5B88919EDguX7Qi5YjnAc=
X-Google-Smtp-Source: ABdhPJz2LqbKNjobm3Rc7VH8/i/n7DtwQouS3T5OlkWSon2KdMn1cqvosvigxzj/f7JG6YwBuTiPLg==
X-Received: by 2002:a5d:4f11:: with SMTP id c17mr6759942wru.388.1613432356731;
        Mon, 15 Feb 2021 15:39:16 -0800 (PST)
Received: from [192.168.1.5] ([41.82.187.251])
        by smtp.gmail.com with ESMTPSA id z17sm14022092wrv.9.2021.02.15.15.39.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 15 Feb 2021 15:39:16 -0800 (PST)
Message-ID: <602b0624.1c69fb81.87c80.5262@mx.google.com>
Sender: skylar anderson <ccalantha4@gmail.com>
From:   monica brown <sgtandersonskylar1@gmail.com>
X-Google-Original-From: monica brown
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: hi dear
To:     Recipients <monica@vger.kernel.org>
Date:   Mon, 15 Feb 2021 23:39:13 +0000
Reply-To: sgt.monica.lin.brown100@gmail.com
X-Mailer: cdcaafe51be8cdb99a1c85906066cad3d0e60e273541515a58395093a7c4e1f0eefb01d7fc4e6278706e9fb8c4dad093c3263345202970888b6b4d817f9e998c032e7d59
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do you speak English
