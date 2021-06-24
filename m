Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5B23B2AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 10:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhFXIuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 04:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhFXIus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:50:48 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237F2C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:48:30 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id t131-20020a37aa890000b02903a9f6c1e8bfso5895240qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lv2M20z/E4ZxJIA5BSrsj1Pd/uieTDDMaCAFj2QM1E8=;
        b=IeSP/P+6W72fNG1FYxWpwjwWHSvA4GP51ldPbpR8fGH8ihBxnYZRyLqIvkWwEohXQ0
         w2lEcMUn26vViVoVh35zcG9nnPfIXrPt4UXymf8gXIqhjcKIJBmCybVwAqDEGCp6i8dM
         1jvDvQSulXTiNegPxp6P2VTY2yGZn6VrI935s/OR9ejkzTPtCpI78FYfk8oAVPHcZuhu
         Wl4MlcV96PtLq9Ku2OzSkaqzqYpDGbzEqCmvh7K7Wr3i5id+P72AGNMJZnkNJaf6AgNA
         kV+kQlahP9hRjQ3Q3W4u+DZGbxEvKY6TOGAr7azm7jNyStvKz/ugRVczpalIMxIlHbRt
         GCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lv2M20z/E4ZxJIA5BSrsj1Pd/uieTDDMaCAFj2QM1E8=;
        b=iJGsvze5Gbl1MXjzCJ1UkqMozedw/SxQgb6njllFZkyGN4B6JelZrPVl7oLPzCkZJP
         wV+xpujXiJSMeHoPDHhSkuGiFJ32958/gKZDg8O8CPkjHRnKhptCMoVYL8QqlR1MyZbz
         db8Rr/vAvvRz2x2iXwfUXeVOzdNNKWF/38GTVte4xKIjGbBOx1Eq8OjTgCqxr8728geM
         HlNMMoneQ2xm5fOGcynHPxEnJy1N62Oc+sTax0e2dRtZwFOCkbySCg2XYdS1O0/1DCsn
         AYo30NcuMmJjS/3B3ejxOBQ7L6s4zC2oticszIxHIQFC+wAK0ZPH4FS7Wo6heD57X7sE
         PDkQ==
X-Gm-Message-State: AOAM532Ia4WJq5xDZCybrZq5/c8yRfhSFcU65zvSiNk+guxLHWyNCSOj
        QoaKD6tVY4my/P37h20wRjCqcp1JARCxCQ==
X-Google-Smtp-Source: ABdhPJwz1UOj+BLfRPLtOTXYIGACJG+pK0CeffrKCgJOCpSZdJGztv47Cvb+WbdaCzYGKtiNvpeWn//XiWqIdw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:a802:69a8:1b1e:dc34])
 (user=davidgow job=sendgmr) by 2002:ad4:58f2:: with SMTP id
 di18mr4493438qvb.4.1624524509302; Thu, 24 Jun 2021 01:48:29 -0700 (PDT)
Date:   Thu, 24 Jun 2021 01:48:23 -0700
Message-Id: <20210624084823.15031-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH kunit-next] thunderbolt: test: Reinstate a few casts of bitfields
From:   David Gow <davidgow@google.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-usb@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Partially revert "thunderbolt: test: Remove some casts which are no
longer required". It turns out that typeof() doesn't support bitfields,
so these still need to be cast to the appropriate enum.

The only mention of typeof() and bitfields I can find is in the proposal
to standardise them:
http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2619.htm

This was caught by the kernel test robot:
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/FDKBHAV7QNLNFU5NBI2RKV56DWDSOLGM/

Fixes: 	8f0877c26e ("thunderbolt: test: Remove some casts which are no longer required")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Whoops: I didn't notice this was broken earlier. If it's easier to just
revert the broken patch, that's fine, too.

Cheers,
-- David

 drivers/thunderbolt/test.c | 66 +++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
index 247dc9f4757e..3cc36ef639f3 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -384,7 +384,8 @@ static void tb_test_path_single_hop_walk(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
+				test_data[i].type);
 		i++;
 	}
 
@@ -395,7 +396,8 @@ static void tb_test_path_single_hop_walk(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
+				test_data[i].type);
 		i--;
 	}
 
@@ -441,7 +443,8 @@ static void tb_test_path_daisy_chain_walk(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
+				test_data[i].type);
 		i++;
 	}
 
@@ -452,7 +455,8 @@ static void tb_test_path_daisy_chain_walk(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
+				test_data[i].type);
 		i--;
 	}
 
@@ -502,7 +506,8 @@ static void tb_test_path_simple_tree_walk(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
+				test_data[i].type);
 		i++;
 	}
 
@@ -513,7 +518,8 @@ static void tb_test_path_simple_tree_walk(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
+				test_data[i].type);
 		i--;
 	}
 
@@ -584,7 +590,8 @@ static void tb_test_path_complex_tree_walk(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
+				test_data[i].type);
 		i++;
 	}
 
@@ -595,7 +602,8 @@ static void tb_test_path_complex_tree_walk(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
+				test_data[i].type);
 		i--;
 	}
 
@@ -685,7 +693,8 @@ static void tb_test_path_max_length_walk(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
+				test_data[i].type);
 		i++;
 	}
 
@@ -696,7 +705,8 @@ static void tb_test_path_max_length_walk(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, i < ARRAY_SIZE(test_data));
 		KUNIT_EXPECT_EQ(test, tb_route(p->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, p->port, test_data[i].port);
-		KUNIT_EXPECT_EQ(test, p->config.type, test_data[i].type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)p->config.type,
+				test_data[i].type);
 		i--;
 	}
 
@@ -779,10 +789,12 @@ static void tb_test_path_not_bonded_lane0(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
-		KUNIT_EXPECT_EQ(test, in_port->config.type, test_data[i].in_type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
+				test_data[i].in_type);
 		KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
-		KUNIT_EXPECT_EQ(test, out_port->config.type, test_data[i].out_type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
+				test_data[i].out_type);
 	}
 	tb_path_free(path);
 }
@@ -839,10 +851,12 @@ static void tb_test_path_not_bonded_lane1(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
-		KUNIT_EXPECT_EQ(test, in_port->config.type, test_data[i].in_type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
+				test_data[i].in_type);
 		KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
-		KUNIT_EXPECT_EQ(test, out_port->config.type, test_data[i].out_type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
+				test_data[i].out_type);
 	}
 	tb_path_free(path);
 }
@@ -917,10 +931,12 @@ static void tb_test_path_not_bonded_lane1_chain(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
-		KUNIT_EXPECT_EQ(test, in_port->config.type, test_data[i].in_type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
+				test_data[i].in_type);
 		KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
-		KUNIT_EXPECT_EQ(test, out_port->config.type, test_data[i].out_type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
+				test_data[i].out_type);
 	}
 	tb_path_free(path);
 }
@@ -995,10 +1011,12 @@ static void tb_test_path_not_bonded_lane1_chain_reverse(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
-		KUNIT_EXPECT_EQ(test, in_port->config.type, test_data[i].in_type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
+				test_data[i].in_type);
 		KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
-		KUNIT_EXPECT_EQ(test, out_port->config.type, test_data[i].out_type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
+				test_data[i].out_type);
 	}
 	tb_path_free(path);
 }
@@ -1085,10 +1103,12 @@ static void tb_test_path_mixed_chain(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
-		KUNIT_EXPECT_EQ(test, in_port->config.type, test_data[i].in_type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
+				test_data[i].in_type);
 		KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
-		KUNIT_EXPECT_EQ(test, out_port->config.type, test_data[i].out_type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
+				test_data[i].out_type);
 	}
 	tb_path_free(path);
 }
@@ -1175,10 +1195,12 @@ static void tb_test_path_mixed_chain_reverse(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
-		KUNIT_EXPECT_EQ(test, in_port->config.type, test_data[i].in_type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
+				test_data[i].in_type);
 		KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
 		KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
-		KUNIT_EXPECT_EQ(test, out_port->config.type, test_data[i].out_type);
+		KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
+				test_data[i].out_type);
 	}
 	tb_path_free(path);
 }
-- 
2.32.0.288.g62a8d224e6-goog

