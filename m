Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2ABE388289
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352679AbhERWCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236677AbhERWCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621375280;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8m+jYW6+fTBKwZ4IhDzeGXZrXoA3zhxAssLuHuE9L0g=;
        b=H9vWXV4iPjPIWMXr7AXm+f+wNVPoiG/FBLBEoRJskYdTO0ilVaalhrIpPrsVRi3w3a7IMW
        0qrwXXqvTGkpO+8ZvE0+xkYo1cmrS5Uwk1j8YxWcsXNMybqdn5JnXVtBX+9Sndd864V/fe
        oIYmZPEcxJjV6vgwC+nJCuzFI51KDlA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-QxihQEwPOsm09xsI6ghuTQ-1; Tue, 18 May 2021 18:01:17 -0400
X-MC-Unique: QxihQEwPOsm09xsI6ghuTQ-1
Received: by mail-qv1-f70.google.com with SMTP id l19-20020a0ce5130000b02901b6795e3304so8565512qvm.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=8m+jYW6+fTBKwZ4IhDzeGXZrXoA3zhxAssLuHuE9L0g=;
        b=TfwzjTk0ZWazYjyrh/w25X3nUK5RB+QG1kgAmAz2v6XjQR0n1TzS+sHplNxchulJnn
         h923NwwypjkaKrfHtl7PV92tF9gHa8sfmzcS+cIfEwaQ18muyE1LCvOP4Kt1gybczfeA
         lHXZNpWIx/yGvsjF5RJtFjXIU6QZ088Lwz1xbZlGVtZ3oKK7jKPTY21dRWB6o3JfJuDV
         L+xhSg9k2pwY0hEGdGy+sjVJgFfaLhLjHRi7cnu10ywmxueqRMi2tPZAMskeT09i17rG
         BX+HJ6Wr0Lc0mHfm3LfmTVWBdDHHjm8m9r98Mi67hgR3JVCZiKa8KABciOM3x6DBtJrP
         LzjA==
X-Gm-Message-State: AOAM530GpjhjPUoPE2zfM397xJYJJiEQhh6qDKo6UTUiMj+JMVKy5j0j
        s4jRd1MX3YFbpiDXKbahkk4eS9Axs8ZEiENLngs1/Piytey34ErvBbBrJmfgn6SxasfXVAUs+xR
        BERfNcC0kiv1vObC6C0G+wPsG
X-Received: by 2002:a05:6214:842:: with SMTP id dg2mr8837051qvb.4.1621375276805;
        Tue, 18 May 2021 15:01:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5odkjhfIbaitVr0xPbJ2wGqzmyXeo6gZoCY+tdXf7+gYTm54zQg3Te1mIUXSWG7NbP3TO9g==
X-Received: by 2002:a05:6214:842:: with SMTP id dg2mr8837018qvb.4.1621375276562;
        Tue, 18 May 2021 15:01:16 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id f12sm14049018qtj.26.2021.05.18.15.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 15:01:16 -0700 (PDT)
Message-ID: <faee62cc5308ded52538c5bab8d47cd1d01e42c2.camel@redhat.com>
Subject: Re: [PATCH v4 1/3] drm/dp_mst: Add self-tests for up requests
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Sam McNally <sammc@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Date:   Tue, 18 May 2021 18:01:15 -0400
In-Reply-To: <20210518223508.v4.1.I6f50a7996687318ba298c24a3663c8be7dd432c7@changeid>
References: <20210518223508.v4.1.I6f50a7996687318ba298c24a3663c8be7dd432c7@changeid>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like these tests might still need to be fixed up a bit:

[   34.785042]  (null): [drm:drm_dp_sideband_parse_req [drm_kms_helper]] connection status reply parse length fail 2 1
[   34.785082]  (null): [drm:drm_dp_sideband_parse_req [drm_kms_helper]] resource status reply parse length fail 2 1
[   34.785114]  (null): [drm:drm_dp_sideband_parse_req [drm_kms_helper]] sink event notify parse length fail 2 1
[   34.785146]  (null): [drm] *ERROR* Got unknown request 0x23 (REMOTE_I2C_WRITE)


On Tue, 2021-05-18 at 22:35 +1000, Sam McNally wrote:
Up requests are decoded by drm_dp_sideband_parse_req(), which operates
on a drm_dp_sideband_msg_rx, unlike down requests. Expand the existing
self-test helper sideband_msg_req_encode_decode() to copy the message
contents and length from a drm_dp_sideband_msg_tx to
drm_dp_sideband_msg_rx and use the parse function under test in place of
decode.

Add support for currently-supported up requests to
drm_dp_dump_sideband_msg_req_body(); add support to
drm_dp_encode_sideband_req() to allow encoding for the self-tests.

Add self-tests for CONNECTION_STATUS_NOTIFY and RESOURCE_STATUS_NOTIFY.

Signed-off-by: Sam McNally <sammc@chromium.org>
---

Changes in v4:
- New in v4

 drivers/gpu/drm/drm_dp_mst_topology.c         |  54 ++++++-
 .../gpu/drm/drm_dp_mst_topology_internal.h    |   4 +
 .../drm/selftests/test-drm_dp_mst_helper.c    | 147 ++++++++++++++++--
 3 files changed, 190 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
b/drivers/gpu/drm/drm_dp_mst_topology.c
index 54604633e65c..573f39a3dc16 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -442,6 +442,37 @@ drm_dp_encode_sideband_req(const struct
drm_dp_sideband_msg_req_body *req,
                idx++;
                }
                break;
+       case DP_CONNECTION_STATUS_NOTIFY: {
+               const struct drm_dp_connection_status_notify *msg;
+
+               msg = &req->u.conn_stat;
+               buf[idx] = (msg->port_number & 0xf) << 4;
+               idx++;
+               memcpy(&raw->msg[idx], msg->guid, 16);
+               idx += 16;
+               raw->msg[idx] = 0;
+               raw->msg[idx] |= msg->legacy_device_plug_status ? BIT(6) : 0;
+               raw->msg[idx] |= msg->displayport_device_plug_status ? BIT(5) :
0;
+               raw->msg[idx] |= msg->message_capability_status ? BIT(4) : 0;
+               raw->msg[idx] |= msg->input_port ? BIT(3) : 0;
+               raw->msg[idx] |= FIELD_PREP(GENMASK(2, 0), msg-
>peer_device_type);
+               idx++;
+               break;
+       }
+       case DP_RESOURCE_STATUS_NOTIFY: {
+               const struct drm_dp_resource_status_notify *msg;
+
+               msg = &req->u.resource_stat;
+               buf[idx] = (msg->port_number & 0xf) << 4;
+               idx++;
+               memcpy(&raw->msg[idx], msg->guid, 16);
+               idx += 16;
+               buf[idx] = (msg->available_pbn & 0xff00) >> 8;
+               idx++;
+               buf[idx] = (msg->available_pbn & 0xff);
+               idx++;
+               break;
+       }
        }
        raw->cur_len = idx;
 }
@@ -672,6 +703,22 @@ drm_dp_dump_sideband_msg_req_body(const struct
drm_dp_sideband_msg_req_body *req
                  req->u.enc_status.stream_behavior,
                  req->u.enc_status.valid_stream_behavior);
                break;
+       case DP_CONNECTION_STATUS_NOTIFY:
+               P("port=%d guid=%*ph legacy=%d displayport=%d messaging=%d
input=%d peer_type=%d",
+                 req->u.conn_stat.port_number,
+                 (int)ARRAY_SIZE(req->u.conn_stat.guid), req->u.conn_stat.guid,
+                 req->u.conn_stat.legacy_device_plug_status,
+                 req->u.conn_stat.displayport_device_plug_status,
+                 req->u.conn_stat.message_capability_status,
+                 req->u.conn_stat.input_port,
+                 req->u.conn_stat.peer_device_type);
+               break;
+       case DP_RESOURCE_STATUS_NOTIFY:
+               P("port=%d guid=%*ph pbn=%d",
+                 req->u.resource_stat.port_number,
+                 (int)ARRAY_SIZE(req->u.resource_stat.guid), req-
>u.resource_stat.guid,
+                 req->u.resource_stat.available_pbn);
+               break;
        default:
                P("???\n");
                break;
@@ -1116,9 +1163,9 @@ static bool
drm_dp_sideband_parse_resource_status_notify(const struct drm_dp_mst
        return false;
 }
 
-static bool drm_dp_sideband_parse_req(const struct drm_dp_mst_topology_mgr
*mgr,
-                                     struct drm_dp_sideband_msg_rx *raw,
-                                     struct drm_dp_sideband_msg_req_body *msg)
+bool drm_dp_sideband_parse_req(const struct drm_dp_mst_topology_mgr *mgr,
+                              struct drm_dp_sideband_msg_rx *raw,
+                              struct drm_dp_sideband_msg_req_body *msg)
 {
        memset(msg, 0, sizeof(*msg));
        msg->req_type = (raw->msg[0] & 0x7f);
@@ -1134,6 +1181,7 @@ static bool drm_dp_sideband_parse_req(const struct
drm_dp_mst_topology_mgr *mgr,
                return false;
        }
 }
+EXPORT_SYMBOL_FOR_TESTS_ONLY(drm_dp_sideband_parse_req);
 
 static void build_dpcd_write(struct drm_dp_sideband_msg_tx *msg,
                             u8 port_num, u32 offset, u8 num_bytes, u8 *bytes)
diff --git a/drivers/gpu/drm/drm_dp_mst_topology_internal.h
b/drivers/gpu/drm/drm_dp_mst_topology_internal.h
index eeda9a61c657..0356a2e0dba1 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology_internal.h
+++ b/drivers/gpu/drm/drm_dp_mst_topology_internal.h
@@ -21,4 +21,8 @@ void
 drm_dp_dump_sideband_msg_req_body(const struct drm_dp_sideband_msg_req_body
*req,
                                  int indent, struct drm_printer *printer);
 
+bool
+drm_dp_sideband_parse_req(const struct drm_dp_mst_topology_mgr *mgr,
+                         struct drm_dp_sideband_msg_rx *raw,
+                         struct drm_dp_sideband_msg_req_body *msg);
 #endif /* !_DRM_DP_MST_HELPER_INTERNAL_H_ */
diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
index 6b4759ed6bfd..22aaedc63aec 100644
--- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
@@ -13,6 +13,10 @@
 #include "../drm_dp_mst_topology_internal.h"
 #include "test-drm_modeset_common.h"
 
+static void mock_release(struct device *dev)
+{
+}
+
 int igt_dp_mst_calc_pbn_mode(void *ignored)
 {
        int pbn, i;
@@ -120,27 +124,59 @@ sideband_msg_req_equal(const struct
drm_dp_sideband_msg_req_body *in,
 static bool
 sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
 {
-       struct drm_dp_sideband_msg_req_body *out;
+       struct drm_dp_sideband_msg_req_body *out = NULL;
        struct drm_printer p = drm_err_printer(PREFIX_STR);
-       struct drm_dp_sideband_msg_tx *txmsg;
+       struct drm_dp_sideband_msg_tx *txmsg = NULL;
+       struct drm_dp_sideband_msg_rx *rxmsg = NULL;
+       struct drm_dp_mst_topology_mgr *mgr = NULL;
        int i, ret;
-       bool result = true;
+       bool result = false;
 
        out = kzalloc(sizeof(*out), GFP_KERNEL);
        if (!out)
-               return false;
+               goto out;
 
        txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
        if (!txmsg)
-               return false;
+               goto out;
 
-       drm_dp_encode_sideband_req(in, txmsg);
-       ret = drm_dp_decode_sideband_req(txmsg, out);
-       if (ret < 0) {
-               drm_printf(&p, "Failed to decode sideband request: %d\n",
-                          ret);
-               result = false;
+       rxmsg = kzalloc(sizeof(*rxmsg), GFP_KERNEL);
+       if (!rxmsg)
                goto out;
+
+       mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
+       if (!mgr)
+               goto out;
+
+       mgr->dev = kzalloc(sizeof(*mgr->dev), GFP_KERNEL);
+       if (!mgr->dev)
+               goto out;
+
+       mgr->dev->dev = kzalloc(sizeof(*mgr->dev->dev), GFP_KERNEL);
+       if (!mgr->dev->dev)
+               goto out;
+
+       mgr->dev->dev->release = mock_release;
+       device_initialize(mgr->dev->dev);
+
+       drm_dp_encode_sideband_req(in, txmsg);
+       switch (in->req_type) {
+       case DP_CONNECTION_STATUS_NOTIFY:
+       case DP_RESOURCE_STATUS_NOTIFY:
+               memcpy(&rxmsg->msg, txmsg->msg, ARRAY_SIZE(rxmsg->msg));
+               rxmsg->curlen = txmsg->cur_len;
+               if (!drm_dp_sideband_parse_req(mgr, rxmsg, out)) {
+                       drm_printf(&p, "Failed to decode sideband request\n");
+                       goto out;
+               }
+               break;
+       default:
+               ret = drm_dp_decode_sideband_req(txmsg, out);
+               if (ret < 0) {
+                       drm_printf(&p, "Failed to decode sideband request:
%d\n", ret);
+                       goto out;
+               }
+               break;
        }
 
        if (!sideband_msg_req_equal(in, out)) {
@@ -148,9 +184,9 @@ sideband_msg_req_encode_decode(struct
drm_dp_sideband_msg_req_body *in)
                drm_dp_dump_sideband_msg_req_body(in, 1, &p);
                drm_printf(&p, "Got:\n");
                drm_dp_dump_sideband_msg_req_body(out, 1, &p);
-               result = false;
                goto out;
        }
+       result = true;
 
        switch (in->req_type) {
        case DP_REMOTE_DPCD_WRITE:
@@ -171,6 +207,65 @@ sideband_msg_req_encode_decode(struct
drm_dp_sideband_msg_req_body *in)
 out:
        kfree(out);
        kfree(txmsg);
+       kfree(rxmsg);
+       if (mgr) {
+               if (mgr->dev) {
+                       put_device(mgr->dev->dev);
+                       kfree(mgr->dev);
+               }
+               kfree(mgr);
+       }
+       return result;
+}
+
+static bool
+sideband_msg_req_parse(int req_type)
+{
+       struct drm_dp_sideband_msg_req_body *out = NULL;
+       struct drm_printer p = drm_err_printer(PREFIX_STR);
+       struct drm_dp_sideband_msg_rx *rxmsg = NULL;
+       struct drm_dp_mst_topology_mgr *mgr = NULL;
+       bool result = false;
+
+       out = kzalloc(sizeof(*out), GFP_KERNEL);
+       if (!out)
+               goto out;
+
+       rxmsg = kzalloc(sizeof(*rxmsg), GFP_KERNEL);
+       if (!rxmsg)
+               goto out;
+
+       mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
+       if (!mgr)
+               goto out;
+
+       mgr->dev = kzalloc(sizeof(*mgr->dev), GFP_KERNEL);
+       if (!mgr->dev)
+               goto out;
+
+       mgr->dev->dev = kzalloc(sizeof(*mgr->dev->dev), GFP_KERNEL);
+       if (!mgr->dev->dev)
+               goto out;
+
+       mgr->dev->dev->release = mock_release;
+       device_initialize(mgr->dev->dev);
+
+       rxmsg->curlen = 1;
+       rxmsg->msg[0] = req_type & 0x7f;
+       if (drm_dp_sideband_parse_req(mgr, rxmsg, out))
+               drm_printf(&p, "Unexpectedly decoded invalid sideband
request\n");
+       else
+               result = true;
+out:
+       kfree(out);
+       kfree(rxmsg);
+       if (mgr) {
+               if (mgr->dev) {
+                       put_device(mgr->dev->dev);
+                       kfree(mgr->dev);
+               }
+               kfree(mgr);
+       }
        return result;
 }
 
@@ -268,6 +363,34 @@ int igt_dp_mst_sideband_msg_req_decode(void *unused)
        in.u.enc_status.valid_stream_behavior = 1;
        DO_TEST();
 
+       in.req_type = DP_CONNECTION_STATUS_NOTIFY;
+       in.u.conn_stat.port_number = 0xf;
+       get_random_bytes(in.u.conn_stat.guid, sizeof(in.u.conn_stat.guid));
+       in.u.conn_stat.legacy_device_plug_status = 1;
+       in.u.conn_stat.displayport_device_plug_status = 0;
+       in.u.conn_stat.message_capability_status = 0;
+       in.u.conn_stat.input_port = 0;
+       in.u.conn_stat.peer_device_type = 7;
+       DO_TEST();
+       in.u.conn_stat.displayport_device_plug_status = 1;
+       DO_TEST();
+       in.u.conn_stat.message_capability_status = 1;
+       DO_TEST();
+       in.u.conn_stat.input_port = 1;
+       DO_TEST();
+
+       in.req_type = DP_RESOURCE_STATUS_NOTIFY;
+       in.u.resource_stat.port_number = 0xf;
+       get_random_bytes(in.u.resource_stat.guid,
sizeof(in.u.resource_stat.guid));
+       in.u.resource_stat.available_pbn = 0xcdef;
+       DO_TEST();
+
+#undef DO_TEST
+#define DO_TEST(req_type) FAIL_ON(!sideband_msg_req_parse(req_type))
+       DO_TEST(DP_CONNECTION_STATUS_NOTIFY);
+       DO_TEST(DP_RESOURCE_STATUS_NOTIFY);
+
+       DO_TEST(DP_REMOTE_I2C_WRITE);
 #undef DO_TEST
        return 0;
 }

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

