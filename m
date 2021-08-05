Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB143E1744
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 16:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbhHEOrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 10:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbhHEOrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:47:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02357C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 07:47:32 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cl16-20020a17090af690b02901782c35c4ccso6281433pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=edy2FUsM4lKE526tpe41yT8O3DNMnfRZhTZam4zQsGs=;
        b=VXjIVoF4hmzSZBZAKJ2Q/QSmzALZJ3SM7VZcXJGUfU3w3wDzpjAGW7wC4UCqzggybP
         GXiLpYwJ8P59CN77FQujNQaVHsbxdKLkbApeK0rnakYrABRezlqsDUUVZciUKiZ2106Z
         juqpkfTqq0qD7khmbB8HldXwfMCjD9Y91NcfsTZuWSQu1/hsclWTBi5pw0MFT/jNdCnO
         Q+WL9Y/l2YNX7NUqHn35QZSbM2emclW9+pCeXoH4IypsUNqqToh3m7/MljemmeQnDmXt
         BbiMGTtMXEfx7ztzRqJNbHc5KmZjpU+9xOilnAQ+onxeIN46A3hhPLrTnVvEIkwxXe8+
         wSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=edy2FUsM4lKE526tpe41yT8O3DNMnfRZhTZam4zQsGs=;
        b=qBruQKd9uUGnroIf2J+qHmaPu7jR9G8CRysIQ1UQCv3ZALhXxzlzLTwceRBgusZZNb
         CGr7wDwTYn9zXFW8zOd6JDQxULGCsH2K9WOJRslOW5kIQCIfI4aPrQhYGgCt/n2ywmGl
         Mc4RBbva8OYGLbd01wrLiknbqmHFOYQJyAj6xgulcfbyuBqHdMCUsOmZnbAhUu+6WzQa
         qg1eCHqyIiFCnOT02ZnwZYPMVMyudWq1wa5f9r0oT0hNQuB5kVN/LC7CPeB9Nkfu6vuj
         yLmoXsNYZ3A4RRnUiWHT2UHdRsk5afv+lHJKCRpfnuIQO/AEu8EhHaN/JSsRKIn2tZ8L
         j4ug==
X-Gm-Message-State: AOAM530+/B7Vo/kUj/Gk/8ohanAHlXSax+YbAHAtCUafASI7qJYCV0x7
        jHWyh5k4Gjh/xGQ3N8jR8es=
X-Google-Smtp-Source: ABdhPJzpwnTWB7O3cd5Ox20HLVd4jowfmW0oyuwXIe76RXUEQvgYyp9MFDXUQirSSW+igxYnEQc8+A==
X-Received: by 2002:aa7:8683:0:b029:3c4:877b:da34 with SMTP id d3-20020aa786830000b02903c4877bda34mr5460079pfo.69.1628174851579;
        Thu, 05 Aug 2021 07:47:31 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id o22sm6927236pfu.87.2021.08.05.07.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 07:47:31 -0700 (PDT)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     mhocko@suse.com
Cc:     akpm@linux-foundation.org, chenguanyou9338@gmail.com,
        chenguanyou@xiaomi.com, gpiccoli@canonical.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, vbabka@suse.cz
Subject: Re:[PATCH v2] hungtask: add filter kthread
Date:   Thu,  5 Aug 2021 22:47:20 +0800
Message-Id: <20210805144720.30358-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YQvxf0KqvlVSO+R5@dhcp22.suse.cz>
References: <YQvxf0KqvlVSO+R5@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Either those kernel threads should be fixed to use less sleep or
> annotate the sleep properly (TASK_IDLE).

The API for debugging when we no need care kernel threads state.

Guanyou.Chen
