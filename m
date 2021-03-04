Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E5632DA07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhCDTHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhCDTGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:06:32 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1280C061574;
        Thu,  4 Mar 2021 11:05:51 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id t1so6393805eds.7;
        Thu, 04 Mar 2021 11:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p58+0o4uqMmKmvzeYcY13piQZC9rd6VxMpXxB4vRqvY=;
        b=dB2J+ZSaSwNo62u3OPf+oT3o0E1F/6YVZdeVe8psTNi7cqt4vhg9ABZjbCIUyDgFwx
         81zLNTLkaWQTUhA9M/+J6yfgv4+kbrE7rR/cw/1FEug2igDbx7bnebkXKxf7WRl777fD
         MinnpvtF+cHviCFh+VoxYFdFPQrJegg11LZWGquhfxZUDAlq5FuG74CyQu41WeW0kO25
         4bDS64/rALB0P3bwGAGwjb8v04oV88WcoJUq59zct1IfW44aL04x5Apm7+zszbpqDWE2
         ZMtjK9jkjyn06EP8HIDko1osy6u6s3z82qnOTF+DbpBD/9aQfjtaQII8h9Wz36RWar/p
         qGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p58+0o4uqMmKmvzeYcY13piQZC9rd6VxMpXxB4vRqvY=;
        b=X4NyRpkgkqzq9mI+I+OwyMHxXG1tPkBc/LVnPGDuLq2t6RPufMwaon2g5HqZ9YdHyG
         Uj0OUWWD/7utsVvaDpEAP5EPMKsMr1S++Yc42J/lyRMMpnPWaVaS/WpM0FJZUZUDj0hm
         qZkDx3+AM0+0FGja1FMC97pU2tEF5yiv2XEfAgv+uwX7FqJZRT58b+PjK+AhgqCXBd1s
         dSZB1pJbvatcK7O+7Qcsqz1fLL33vLzpIEikJUQNiSHv5s83yqfBqgUgPAC1hzcNLayX
         rT6ro+xRdOx5kONmk+Yttk+cKDUTOHufYE1r5l+ufbNeIdSBqXVOGRJgItyoXE0xpLng
         5Esg==
X-Gm-Message-State: AOAM532TkCt/8jFNYR4FL9oPuZo81xh38D/47vnerCaY2G++pbqAY/LZ
        NAVcG3cRjZlPb3zz+8xua/s=
X-Google-Smtp-Source: ABdhPJxfq4hFUn5uIdSMcbxH0MftwDQc129T8v+tcsRAsoifEDBFRHmrPCp/eci1dpLovZQdq+tcRg==
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr6112426edv.116.1614884750243;
        Thu, 04 Mar 2021 11:05:50 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id q2sm141451edv.93.2021.03.04.11.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 11:05:49 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] platform/surface: aggregator: Make SSAM_DEFINE_SYNC_REQUEST_x define static functions
Date:   Thu,  4 Mar 2021 20:05:24 +0100
Message-Id: <20210304190524.1172197-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SSAM_DEFINE_SYNC_REQUEST_x() macros are intended to reduce
boiler-plate code for SSAM request definitions by defining a wrapper
function for the specified request. The client device variants of those
macros, i.e. SSAM_DEFINE_SYNC_REQUEST_CL_x() in particular rely on the
multi-device (MD) variants, e.g.:

    #define SSAM_DEFINE_SYNC_REQUEST_CL_R(name, rtype, spec...)   \
        SSAM_DEFINE_SYNC_REQUEST_MD_R(__raw_##name, rtype, spec)  \
        int name(struct ssam_device *sdev, rtype *ret)            \
        {                                                         \
            return __raw_##name(sdev->ctrl, sdev->uid.target,     \
                                sdev->uid.instance, ret);         \
        }

This now creates the problem that it is not possible to declare the
generated functions static via

    static SSAM_DEFINE_SYNC_REQUEST_CL_R(...)

as this will only apply to the function defined by the multi-device
macro, i.e. SSAM_DEFINE_SYNC_REQUEST_MD_R(). Thus compiling with
`-Wmissing-prototypes' rightfully complains that there is a 'static'
keyword missing.

To solve this, make all SSAM_DEFINE_SYNC_REQUEST_x() macros define
static functions. Non-client-device macros are also changed for
consistency. In general, we expect those functions to be only used
locally in the respective drivers for the corresponding interfaces, so
having to define a wrapper function to be able to export this should be
the odd case out.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 510c8114fc74 ("platform/surface: Add platform profile driver")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../driver-api/surface_aggregator/client.rst  |  4 +-
 .../platform/surface/aggregator/controller.c  | 10 +--
 .../surface/surface_aggregator_registry.c     |  2 +-
 .../surface/surface_platform_profile.c        |  4 +-
 include/linux/surface_aggregator/controller.h | 74 +++++++++----------
 include/linux/surface_aggregator/device.h     | 31 ++++----
 6 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/Documentation/driver-api/surface_aggregator/client.rst b/Documentation/driver-api/surface_aggregator/client.rst
index 26d13085a117..e519d374c378 100644
--- a/Documentation/driver-api/surface_aggregator/client.rst
+++ b/Documentation/driver-api/surface_aggregator/client.rst
@@ -248,7 +248,7 @@ This example defines a function
 
 .. code-block:: c
 
-   int __ssam_tmp_perf_mode_set(struct ssam_controller *ctrl, const __le32 *arg);
+   static int __ssam_tmp_perf_mode_set(struct ssam_controller *ctrl, const __le32 *arg);
 
 executing the specified request, with the controller passed in when calling
 said function. In this example, the argument is provided via the ``arg``
@@ -296,7 +296,7 @@ This invocation of the macro defines a function
 
 .. code-block:: c
 
-   int ssam_bat_get_sta(struct ssam_device *sdev, __le32 *ret);
+   static int ssam_bat_get_sta(struct ssam_device *sdev, __le32 *ret);
 
 executing the specified request, using the device IDs and controller given
 in the client device. The full list of such macros for client devices is:
diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index 5bcb59ed579d..aa6f37b4f46e 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -1750,35 +1750,35 @@ EXPORT_SYMBOL_GPL(ssam_request_sync_with_buffer);
 
 /* -- Internal SAM requests. ------------------------------------------------ */
 
-static SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_get_firmware_version, __le32, {
+SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_get_firmware_version, __le32, {
 	.target_category = SSAM_SSH_TC_SAM,
 	.target_id       = 0x01,
 	.command_id      = 0x13,
 	.instance_id     = 0x00,
 });
 
-static SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_display_off, u8, {
+SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_display_off, u8, {
 	.target_category = SSAM_SSH_TC_SAM,
 	.target_id       = 0x01,
 	.command_id      = 0x15,
 	.instance_id     = 0x00,
 });
 
-static SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_display_on, u8, {
+SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_display_on, u8, {
 	.target_category = SSAM_SSH_TC_SAM,
 	.target_id       = 0x01,
 	.command_id      = 0x16,
 	.instance_id     = 0x00,
 });
 
-static SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_d0_exit, u8, {
+SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_d0_exit, u8, {
 	.target_category = SSAM_SSH_TC_SAM,
 	.target_id       = 0x01,
 	.command_id      = 0x33,
 	.instance_id     = 0x00,
 });
 
-static SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_d0_entry, u8, {
+SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_d0_entry, u8, {
 	.target_category = SSAM_SSH_TC_SAM,
 	.target_id       = 0x01,
 	.command_id      = 0x34,
diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index caee90d135c5..cdb4a95af3e8 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -302,7 +302,7 @@ struct ssam_base_hub {
 	struct ssam_event_notifier notif;
 };
 
-static SSAM_DEFINE_SYNC_REQUEST_R(ssam_bas_query_opmode, u8, {
+SSAM_DEFINE_SYNC_REQUEST_R(ssam_bas_query_opmode, u8, {
 	.target_category = SSAM_SSH_TC_BAS,
 	.target_id       = 0x01,
 	.command_id      = 0x0d,
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 0081b01a5b0f..6373d3b5eb7f 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -32,12 +32,12 @@ struct ssam_tmp_profile_device {
 	struct platform_profile_handler handler;
 };
 
-static SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_tmp_profile_get, struct ssam_tmp_profile_info, {
+SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_tmp_profile_get, struct ssam_tmp_profile_info, {
 	.target_category = SSAM_SSH_TC_TMP,
 	.command_id      = 0x02,
 });
 
-static SSAM_DEFINE_SYNC_REQUEST_CL_W(__ssam_tmp_profile_set, __le32, {
+SSAM_DEFINE_SYNC_REQUEST_CL_W(__ssam_tmp_profile_set, __le32, {
 	.target_category = SSAM_SSH_TC_TMP,
 	.command_id      = 0x03,
 });
diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
index f4b1ba887384..0806796eabcb 100644
--- a/include/linux/surface_aggregator/controller.h
+++ b/include/linux/surface_aggregator/controller.h
@@ -344,16 +344,16 @@ struct ssam_request_spec_md {
  * request has been fully completed. The required transport buffer will be
  * allocated on the stack.
  *
- * The generated function is defined as ``int name(struct ssam_controller
- * *ctrl)``, returning the status of the request, which is zero on success and
- * negative on failure. The ``ctrl`` parameter is the controller via which the
- * request is being sent.
+ * The generated function is defined as ``static int name(struct
+ * ssam_controller *ctrl)``, returning the status of the request, which is
+ * zero on success and negative on failure. The ``ctrl`` parameter is the
+ * controller via which the request is being sent.
  *
  * Refer to ssam_request_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_N(name, spec...)				\
-	int name(struct ssam_controller *ctrl)					\
+	static int name(struct ssam_controller *ctrl)				\
 	{									\
 		struct ssam_request_spec s = (struct ssam_request_spec)spec;	\
 		struct ssam_request rqst;					\
@@ -383,17 +383,17 @@ struct ssam_request_spec_md {
  * returning once the request has been fully completed. The required transport
  * buffer will be allocated on the stack.
  *
- * The generated function is defined as ``int name(struct ssam_controller
- * *ctrl, const atype *arg)``, returning the status of the request, which is
- * zero on success and negative on failure. The ``ctrl`` parameter is the
- * controller via which the request is sent. The request argument is specified
- * via the ``arg`` pointer.
+ * The generated function is defined as ``static int name(struct
+ * ssam_controller *ctrl, const atype *arg)``, returning the status of the
+ * request, which is zero on success and negative on failure. The ``ctrl``
+ * parameter is the controller via which the request is sent. The request
+ * argument is specified via the ``arg`` pointer.
  *
  * Refer to ssam_request_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_W(name, atype, spec...)			\
-	int name(struct ssam_controller *ctrl, const atype *arg)		\
+	static int name(struct ssam_controller *ctrl, const atype *arg)		\
 	{									\
 		struct ssam_request_spec s = (struct ssam_request_spec)spec;	\
 		struct ssam_request rqst;					\
@@ -424,17 +424,17 @@ struct ssam_request_spec_md {
  * request itself, returning once the request has been fully completed. The
  * required transport buffer will be allocated on the stack.
  *
- * The generated function is defined as ``int name(struct ssam_controller
- * *ctrl, rtype *ret)``, returning the status of the request, which is zero on
- * success and negative on failure. The ``ctrl`` parameter is the controller
- * via which the request is sent. The request's return value is written to the
- * memory pointed to by the ``ret`` parameter.
+ * The generated function is defined as ``static int name(struct
+ * ssam_controller *ctrl, rtype *ret)``, returning the status of the request,
+ * which is zero on success and negative on failure. The ``ctrl`` parameter is
+ * the controller via which the request is sent. The request's return value is
+ * written to the memory pointed to by the ``ret`` parameter.
  *
  * Refer to ssam_request_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_R(name, rtype, spec...)			\
-	int name(struct ssam_controller *ctrl, rtype *ret)			\
+	static int name(struct ssam_controller *ctrl, rtype *ret)		\
 	{									\
 		struct ssam_request_spec s = (struct ssam_request_spec)spec;	\
 		struct ssam_request rqst;					\
@@ -483,17 +483,17 @@ struct ssam_request_spec_md {
  * returning once the request has been fully completed. The required transport
  * buffer will be allocated on the stack.
  *
- * The generated function is defined as ``int name(struct ssam_controller
- * *ctrl, u8 tid, u8 iid)``, returning the status of the request, which is
- * zero on success and negative on failure. The ``ctrl`` parameter is the
- * controller via which the request is sent, ``tid`` the target ID for the
- * request, and ``iid`` the instance ID.
+ * The generated function is defined as ``static int name(struct
+ * ssam_controller *ctrl, u8 tid, u8 iid)``, returning the status of the
+ * request, which is zero on success and negative on failure. The ``ctrl``
+ * parameter is the controller via which the request is sent, ``tid`` the
+ * target ID for the request, and ``iid`` the instance ID.
  *
  * Refer to ssam_request_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_MD_N(name, spec...)				\
-	int name(struct ssam_controller *ctrl, u8 tid, u8 iid)			\
+	static int name(struct ssam_controller *ctrl, u8 tid, u8 iid)		\
 	{									\
 		struct ssam_request_spec_md s = (struct ssam_request_spec_md)spec; \
 		struct ssam_request rqst;					\
@@ -524,18 +524,18 @@ struct ssam_request_spec_md {
  * the request itself, returning once the request has been fully completed.
  * The required transport buffer will be allocated on the stack.
  *
- * The generated function is defined as ``int name(struct ssam_controller
- * *ctrl, u8 tid, u8 iid, const atype *arg)``, returning the status of the
- * request, which is zero on success and negative on failure. The ``ctrl``
- * parameter is the controller via which the request is sent, ``tid`` the
- * target ID for the request, and ``iid`` the instance ID. The request argument
- * is specified via the ``arg`` pointer.
+ * The generated function is defined as ``static int name(struct
+ * ssam_controller *ctrl, u8 tid, u8 iid, const atype *arg)``, returning the
+ * status of the request, which is zero on success and negative on failure.
+ * The ``ctrl`` parameter is the controller via which the request is sent,
+ * ``tid`` the target ID for the request, and ``iid`` the instance ID. The
+ * request argument is specified via the ``arg`` pointer.
  *
  * Refer to ssam_request_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_MD_W(name, atype, spec...)			\
-	int name(struct ssam_controller *ctrl, u8 tid, u8 iid, const atype *arg)\
+	static int name(struct ssam_controller *ctrl, u8 tid, u8 iid, const atype *arg) \
 	{									\
 		struct ssam_request_spec_md s = (struct ssam_request_spec_md)spec; \
 		struct ssam_request rqst;					\
@@ -567,18 +567,18 @@ struct ssam_request_spec_md {
  * execution of the request itself, returning once the request has been fully
  * completed. The required transport buffer will be allocated on the stack.
  *
- * The generated function is defined as ``int name(struct ssam_controller
- * *ctrl, u8 tid, u8 iid, rtype *ret)``, returning the status of the request,
- * which is zero on success and negative on failure. The ``ctrl`` parameter is
- * the controller via which the request is sent, ``tid`` the target ID for the
- * request, and ``iid`` the instance ID. The request's return value is written
- * to the memory pointed to by the ``ret`` parameter.
+ * The generated function is defined as ``static int name(struct
+ * ssam_controller *ctrl, u8 tid, u8 iid, rtype *ret)``, returning the status
+ * of the request, which is zero on success and negative on failure. The
+ * ``ctrl`` parameter is the controller via which the request is sent, ``tid``
+ * the target ID for the request, and ``iid`` the instance ID. The request's
+ * return value is written to the memory pointed to by the ``ret`` parameter.
  *
  * Refer to ssam_request_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_MD_R(name, rtype, spec...)			\
-	int name(struct ssam_controller *ctrl, u8 tid, u8 iid, rtype *ret)	\
+	static int name(struct ssam_controller *ctrl, u8 tid, u8 iid, rtype *ret) \
 	{									\
 		struct ssam_request_spec_md s = (struct ssam_request_spec_md)spec; \
 		struct ssam_request rqst;					\
diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index 02f3e06c0a60..4441ad667c3f 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -336,17 +336,18 @@ void ssam_device_driver_unregister(struct ssam_device_driver *d);
  * request has been fully completed. The required transport buffer will be
  * allocated on the stack.
  *
- * The generated function is defined as ``int name(struct ssam_device *sdev)``,
- * returning the status of the request, which is zero on success and negative
- * on failure. The ``sdev`` parameter specifies both the target device of the
- * request and by association the controller via which the request is sent.
+ * The generated function is defined as ``static int name(struct ssam_device
+ * *sdev)``, returning the status of the request, which is zero on success and
+ * negative on failure. The ``sdev`` parameter specifies both the target
+ * device of the request and by association the controller via which the
+ * request is sent.
  *
  * Refer to ssam_request_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_CL_N(name, spec...)			\
 	SSAM_DEFINE_SYNC_REQUEST_MD_N(__raw_##name, spec)		\
-	int name(struct ssam_device *sdev)				\
+	static int name(struct ssam_device *sdev)			\
 	{								\
 		return __raw_##name(sdev->ctrl, sdev->uid.target,	\
 				    sdev->uid.instance);		\
@@ -368,19 +369,19 @@ void ssam_device_driver_unregister(struct ssam_device_driver *d);
  * itself, returning once the request has been fully completed. The required
  * transport buffer will be allocated on the stack.
  *
- * The generated function is defined as ``int name(struct ssam_device *sdev,
- * const atype *arg)``, returning the status of the request, which is zero on
- * success and negative on failure. The ``sdev`` parameter specifies both the
- * target device of the request and by association the controller via which
- * the request is sent. The request's argument is specified via the ``arg``
- * pointer.
+ * The generated function is defined as ``static int name(struct ssam_device
+ * *sdev, const atype *arg)``, returning the status of the request, which is
+ * zero on success and negative on failure. The ``sdev`` parameter specifies
+ * both the target device of the request and by association the controller via
+ * which the request is sent. The request's argument is specified via the
+ * ``arg`` pointer.
  *
  * Refer to ssam_request_sync_onstack() for more details on the behavior of
  * the generated function.
  */
 #define SSAM_DEFINE_SYNC_REQUEST_CL_W(name, atype, spec...)		\
 	SSAM_DEFINE_SYNC_REQUEST_MD_W(__raw_##name, atype, spec)	\
-	int name(struct ssam_device *sdev, const atype *arg)		\
+	static int name(struct ssam_device *sdev, const atype *arg)	\
 	{								\
 		return __raw_##name(sdev->ctrl, sdev->uid.target,	\
 				    sdev->uid.instance, arg);		\
@@ -402,8 +403,8 @@ void ssam_device_driver_unregister(struct ssam_device_driver *d);
  * itself, returning once the request has been fully completed. The required
  * transport buffer will be allocated on the stack.
  *
- * The generated function is defined as ``int name(struct ssam_device *sdev,
- * rtype *ret)``, returning the status of the request, which is zero on
+ * The generated function is defined as ``static int name(struct ssam_device
+ * *sdev, rtype *ret)``, returning the status of the request, which is zero on
  * success and negative on failure. The ``sdev`` parameter specifies both the
  * target device of the request and by association the controller via which
  * the request is sent. The request's return value is written to the memory
@@ -414,7 +415,7 @@ void ssam_device_driver_unregister(struct ssam_device_driver *d);
  */
 #define SSAM_DEFINE_SYNC_REQUEST_CL_R(name, rtype, spec...)		\
 	SSAM_DEFINE_SYNC_REQUEST_MD_R(__raw_##name, rtype, spec)	\
-	int name(struct ssam_device *sdev, rtype *ret)			\
+	static int name(struct ssam_device *sdev, rtype *ret)		\
 	{								\
 		return __raw_##name(sdev->ctrl, sdev->uid.target,	\
 				    sdev->uid.instance, ret);		\
-- 
2.30.1

