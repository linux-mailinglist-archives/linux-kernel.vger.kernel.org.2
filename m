Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2131440882D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 11:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbhIMJ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 05:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbhIMJ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 05:28:42 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A306CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 02:27:26 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id h18-20020ad446f2000000b0037a7b48ba05so5079571qvw.19
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 02:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=PQ67016JCuw0wmarW+Gg6xUxvTIMgb10aFiL+BvYQI4=;
        b=bACp10SPODm3tDvhvo4Dpkkwxdi+nk3xl0oBbvKpjfDsvICAiChx+zcS9d7A90g5LD
         Wg1NwP9jYoyxMyLeJD8YwUv66tlgLefn1PrZay80RMlVUfvymfq6SMRP8zydDwetSBmr
         gzR+Bilb8ibQ7TCNUIjrCV1Ye7ncqX5AHxtJEawfL4suKxdXw2H9kdVymNcqo6RO8IVj
         EBhQaHVbnrqNk9N5Db43Ph5cs7a89CMFphm/qcjy2J5iH2Fjg9BJXwTZsoProH6plkYz
         Ty7oXWBZ3IyFMMnXIlCq3kiuFAPF3Wgr245VEEmhgrj5PLgRChR89TJqBoPAr3Xwd7lc
         6G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=PQ67016JCuw0wmarW+Gg6xUxvTIMgb10aFiL+BvYQI4=;
        b=xc2TK1CZMbtRhqgqziGAtSy9kdZdJZAsCMUdQLaHwd+DgJwZCay13i4MqUtNdbaD/t
         Gi6ldO+eWIAYslI6fedkDXImvCwoCkm1oGQ3axEpWjfKykO4vHkg8kJw/4ykLQ0cISoS
         +/1aBztYKo2dzBePzhCJVEhm2pu+AIbagkjtf43bXoWzbQqfUc+xsfjkee/xmb1+ziWG
         s5xU0StPlgv98yUcZpBKKSOmlG00ZQu3/JuZfs3INS/9HOr0nXStSfJLxxO/N9WjfX84
         BRX5Aswab3vQsbp78K6rHRSZ8q/D5wkIpcwhbjwr7VCvfWs7hJw8dTHpDeR+4lDIyHp3
         j/3g==
X-Gm-Message-State: AOAM5300f1W6/mNsAxBFKtkKi251Fj2+UXae1ESigffXoIXgbsMdXo6H
        eEHncbyKbTLlxomMxapAChBszOjxQYVJYg==
X-Google-Smtp-Source: ABdhPJxMQ6XY9sfo57rAG/cK/FlLZ1uUwMeQq7Jr4fgisRGXbfJn0QmMjkHPRA1fD82P8E7cIRdhZ79f6/6VoA==
X-Received: from akailash.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1e6])
 (user=akailash job=sendgmr) by 2002:ad4:57a7:: with SMTP id
 g7mr9762449qvx.42.1631525245649; Mon, 13 Sep 2021 02:27:25 -0700 (PDT)
Date:   Mon, 13 Sep 2021 09:26:42 +0000
Message-Id: <20210913092642.3237796-1-akailash@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] dm-verity: skip verity_handle_error on I/O errors
From:   Akilesh Kailash <akailash@google.com>
Cc:     akailash@google.com, samitolvanen@google.com,
        kernel-team@android.com, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is an I/O error and FEC correction fails, return
an error instead of calling verity_handle_error().

Suggested-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Akilesh Kailash <akailash@google.com>
---
This was discussed in [1] by Sami Tolvanen but was
never implemented.

[1] https://lore.kernel.org/dm-devel/b004e7c7-f795-77ed-19b9-983785780e92@gmail.com/T/#mec4df1ba3f3cb63846875fb2bfc1f8b3100f31f1

 drivers/md/dm-verity-target.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 22a5ac82446a..a6f7c452ee80 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -475,6 +475,7 @@ static int verity_verify_io(struct dm_verity_io *io)
 	struct bvec_iter start;
 	unsigned b;
 	struct crypto_wait wait;
+	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
 	for (b = 0; b < io->n_blocks; b++) {
 		int r;
@@ -529,9 +530,17 @@ static int verity_verify_io(struct dm_verity_io *io)
 		else if (verity_fec_decode(v, io, DM_VERITY_BLOCK_TYPE_DATA,
 					   cur_block, NULL, &start) == 0)
 			continue;
-		else if (verity_handle_err(v, DM_VERITY_BLOCK_TYPE_DATA,
+		else {
+			if (bio->bi_status) {
+				/*
+				 * Error correction failed; Just return error
+				 */
+				return -EIO;
+			}
+			if (verity_handle_err(v, DM_VERITY_BLOCK_TYPE_DATA,
 					   cur_block))
-			return -EIO;
+				return -EIO;
+		}
 	}
 
 	return 0;
-- 
2.33.0.309.g3052b89438-goog

