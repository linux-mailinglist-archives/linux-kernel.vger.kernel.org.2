Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504B632BD6C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452711AbhCCP7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349937AbhCCLAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:00:10 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0662DC06178A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:59:51 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id x29so7829967pgk.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 02:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc:content-transfer-encoding;
        bh=Cqm741eIKfy7Z2aFUUYOAHOGKvABOwoJy9AbBIz6ypU=;
        b=L+M+nKLbw8tF4Bm7D265Y0yNcAvt3xBADYWQveDXPkxMfSn2Obhvlu1JWYWcGnm3wg
         COYehEjb4AKF9996UGCRl2JgmsDQ+X2j7OAi/v+fsEB7YCvFSWTTn/SPqpMI23UBwU4P
         P7m6m1pojg2PeknK2xIuydoWg0q1g8Bu4Pk8NyHEa+Ouw7/nOL8uo0ijUtahCPUdEHIc
         OSJzq/8j339MLEP9OPvSLdlrWYx3xNINhg7HHGaFJiZCQtKKvr3LlWWucnh6pvL1Z0pF
         PSyAYjDOrzb8kmDmaNakjuJ3u+7gjdF4KmAlAYzbeIUniNW5zZMZjNzhfxhXFSbSzPt6
         jXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc:content-transfer-encoding;
        bh=Cqm741eIKfy7Z2aFUUYOAHOGKvABOwoJy9AbBIz6ypU=;
        b=Tv0qTVupte1N3ihn3i56XSFdpzNPUAl0rf9yfBHtR/9bm531EtMdDfWxQlPywFlD64
         jPKlPA5A04zoG5AVY+unxsOA00ppF/dYLQYSpOcK4X3LhEYB1e9b7jmJ6DaFRQyjd64x
         CpBtNh8yz2wgNjhtCLggvKXn91BRcu/xdSfbqlHf2qBiBVRt/8pllPFoL0UHf9zHzVKe
         dMt4oAq2bz1nSP3duDtDftT700gm6m9XwXGhTzvh12+gjIm0w00cVqdtry157ANpPVfO
         uRPffclHiY/NWG3WlWCE2o5CrMfpxMe3D+lZ8IGVZxKibpEqChI+0HpRLb+tzcOH2B93
         i7yw==
X-Gm-Message-State: AOAM532VIv5do4ixRvACD86fdqt9dNOUSFb0S3xKcvkBCh3qYwGzE90+
        a2k+DYpUVLC+G8v/BMNNra/VsUmSID915Mhj5Tk=
X-Received: by 2002:a63:5625:: with SMTP id k37mt18907878pgb.96.1614769190701;
 Wed, 03 Mar 2021 02:59:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7300:53d1:b029:5:7702:1983 with HTTP; Wed, 3 Mar 2021
 02:59:50 -0800 (PST)
Reply-To: atmcarddelivery001@post.com
In-Reply-To: <CAJTqf+J=Z+c2cKVBhh5Q05vkzgvU+_NDxFcFh8F7zFJp5=BBTQ@mail.gmail.com>
References: <CAJTqf+Jyu05_Q19KXMiiA+UZBG57a05s4Tg-CNqAwvsGc42O5w@mail.gmail.com>
 <CAJTqf+K6w3ha9khVn8aOcCWbOe9cZEVbkURk2d7oZkmSv7KTwA@mail.gmail.com>
 <CAJTqf+KSAsjC7A-CeTjCsF+zvrovxOnQR=j37oesHb9Aejh3ug@mail.gmail.com> <CAJTqf+J=Z+c2cKVBhh5Q05vkzgvU+_NDxFcFh8F7zFJp5=BBTQ@mail.gmail.com>
From:   chukwuemeka john <jchukwuemeka679@gmail.com>
Date:   Wed, 3 Mar 2021 10:59:50 +0000
Message-ID: <CAJTqf+KZa5bmTii2QANWUbn-33-nNTiO0GDobxmW3ULVs8GJpw@mail.gmail.com>
Subject: OK
Cc:     chukwuemedani <chukwuemedani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7JWI64WV7ZWY7IS47JqULCDsoJzqsIAg7J207KCE7JeQIOuztOuCuCDrqZTsnbzsnYQg67Cb7JWY
64KY7JqUPw0KDQpoZWxsbyBkZWFyLCBkaWQgeW91IGdldCB0aGUgbWFpbCBpIHNlbnQgeW91IHRo
ZSBwcmV2aW91cyB0aW1lLg0K
