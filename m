Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3FA3CCB98
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 01:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhGRXlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 19:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhGRXlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 19:41:17 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9B9C061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 16:38:17 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso16387268oty.12
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 16:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=J4mbhV9Eu2lgrEFQool5SOXRzWL0qBbW5WP2cb3qRkM=;
        b=WsZMdxRxDBNrw/SI5ZjNwN5Kd5aIsSo7UTOAfohD6JkQS0JmnqBVaggUF5g85l3zlD
         QaBsBnunPjZ4HNb6D5UJUPuNPoJKWL2dv7wSjMDGba228lFXFsSUf/yN+xPzFKiElGJJ
         CAoJusP/Gy+7DrgGMRdAJ0XAw91gJJd08NZJpFZt7oHgvJU+/roVsw9FEUKB+N3l8w2x
         s7EZkJGcHvZxG4NL92SvGkvute6CsfqZYdPr2wO5MXDu43PY7k0ND9yRlA4FzWzN9TKR
         p6X1hTAS5hNKAqwsJchb5qOK5CbhfIFuPPcfKADVGagFc04cQ7g09iAmkWdtVe400pq0
         9juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=J4mbhV9Eu2lgrEFQool5SOXRzWL0qBbW5WP2cb3qRkM=;
        b=a8U+fjiGO+o/l5CDH5CZCrsLKoPqaKCSALwO9Z30tegYOlJ4d8tJwvhlrjNgGrpdP7
         Oe9RnXgb26/NFnwEuTMkZfP82+qrEw2OEPEDjDkMotfGbuifb1QV4QXOXWtkXTYWEw9S
         dFeIuWfq+W41Z8Fv/vtReu3L6ZbsOUOaeXAs2PG+SRBPBWdKohKr52mBNLheNLKW/Wn9
         CMSuuOlQstP5gLh7UMC3UoErsfMgrImefDx6idrgRdtlWNHY0HyvPTCKpo7TC/QMQ51k
         z2XUTQwyCSZHToVAflG9ZrD6nSWMqIVEYkvxwAqqpw7paUcyKCuswpoVXIWMpMAsk+VU
         htpQ==
X-Gm-Message-State: AOAM532mEHIPk4PjDBvULRgTlvTrgMAKYClk6rn8WjUm+n7DUDT+p0WT
        6+szutkKzbxVakD9T0p1f0TWv3900DY++YRA5DxBSjOpYKM=
X-Google-Smtp-Source: ABdhPJw23uf32CLjAGORQzp2zjMwo6rsburDudR5jmTEz75fcA5NazygU3NrNIRfPVYgefPfZDrJNXAwg+r1yd4hBfY=
X-Received: by 2002:a9d:650e:: with SMTP id i14mr16808143otl.233.1626651495834;
 Sun, 18 Jul 2021 16:38:15 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Davis <alex47794@gmail.com>
Date:   Sun, 18 Jul 2021 19:37:45 -0400
Message-ID: <CADiockB1=Bg_v-42Sm=2MPQNHvKqKjcNV_uhhUejteMfFhXYvg@mail.gmail.com>
Subject: [Regression] Laptop screen blank on resume from hibernate in 5.13.x.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I close the lid on my RX580-based laptop and reopen it, the
screen stays blank. A bug report has been submitted:
https://bugzilla.kernel.org/show_bug.cgi?id=213779
