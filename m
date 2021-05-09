Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CAE377769
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 17:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhEIPnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhEIPni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 11:43:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BF3C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 08:42:35 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s25so17733448lji.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 08:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PXgXNpSb7vjgteIty9OCQxIuvvV/8IokdELG1uqHUhs=;
        b=cg46VEhE4vmQ60m8FygJZ+YaG1Jkb9uYbOwlT0FXyAtqzmQCDMVHOLXnmoBvYR5CO9
         1NvqVJLU5VLkME+/eaQr8LkEP1f/A9Tkz5wbK+qa1nznkS9dWEK4XTc3lfjRDlYIbmr3
         GToMzufdkJfDmgbp1Oekreu+oJGOWlvu7fIQQDxIqdy9QFUlEWpbVdu0pCNhfrKMq3tL
         QDR9uevhNEC49kY4e5xmbOziha1AECleTMEssJJAI6ez+cEb5M0lVCgZPT+JmKdWgesa
         lOXt/EdHQcR4SXoXA8N5jAZBPkKjYZQx27oW5w+nKZ8kDcPJn5Ve3IxfuGjpQGq57VPe
         xg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PXgXNpSb7vjgteIty9OCQxIuvvV/8IokdELG1uqHUhs=;
        b=m7apT91QEPkj9yKpV8T6asaaEsB23TjokeEoHbi7bW7BND34MUMhHvvz27z1cmx5Is
         wtyFh/CsQ/aNbF1AG6rJc6uqjSsQIk9tVOXFggXXjV0/0bRwwMw87nhMlTUAYhfpe98e
         QGKUyQ2jQzM/J/ehnOrB0lm78aAoomjlzaY2+GybiGH46yM3w3juE10EIzSzNlICUmHH
         vlvlaXAbsKKb6CWn9Xqci9Wkp4c92D3Cw5cvdwIJVjG/VS5en9H2Z90EoZ3GrwLJXRxZ
         kOP7Fwg7pVRisyR/asbBSZLIPVXC9WC74SFSIzQPI/oE+yB5UulQGx3y/0dJM7RTGt1U
         EeBw==
X-Gm-Message-State: AOAM533rwXFGrH5oISCooML5CXb806xhrEue8MrWpk+0EU+R26lV5CG/
        0knbKzmxCnm+fB23Ua6vgzftotrqMtll+gC3L1WC43Y1QZRDCoj1
X-Google-Smtp-Source: ABdhPJx+juNBJa1Z9PloK2Mz0fuQbGypxZnhZxUFVUtiUKVkR8QCRoxFddt4r2fFv9QHNS14Jqjajg2eeIWpES91vzg=
X-Received: by 2002:a2e:b4b1:: with SMTP id q17mr9235345ljm.40.1620574953684;
 Sun, 09 May 2021 08:42:33 -0700 (PDT)
MIME-Version: 1.0
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 9 May 2021 21:12:22 +0530
Message-ID: <CABJPP5BExfW+xre-3E-9EysYMhLGRzNrkPbTW3qomOKqc31PSQ@mail.gmail.com>
Subject: Codespell dictionary path is no longer absolute
To:     Joe Perches <joe@perches.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A year ago, the codespell dictionary was moved from
/usr/share/codespell/dictionary.txt to data/dictionary.txt under
the codespell_lib installation directory.

checkpatch.pl still has the default codespell path as
/usr/share/codespell/dictionary.txt.
Any new installations will now also need to specify --codespellfile
option along with --codespell.

Can auto detection of the dictionary path be enabled with something
like this?

-----
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23697a6b1eaa..28ca5cfff2d5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -889,6 +889,9 @@ if (open(my $spelling, '<', $spelling_file)) {
}

if ($codespell) {
+       if (! -e "$codespellfile" && which("python") ne "") {
+               $codespellfile = `python -c "import os.path as op; import code
spell_lib; print(op.join(op.dirname(codespell_lib.__file__), 'data', 'dictiona
ry.txt'), end='')"`;
+       }
       if (open(my $spelling, '<', $codespellfile)) {
               while (<$spelling>) {
                       my $line = $_;
-----

Thanks,
Dwaipayan.
