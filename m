Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E2244E9CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhKLPS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:18:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229509AbhKLPS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:18:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3840661039;
        Fri, 12 Nov 2021 15:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636730166;
        bh=qfvAVTLnZQPFhQ7KMBUuCmNugj3x20WHfXtF6eqZqDg=;
        h=From:To:Cc:Subject:Date:From;
        b=Acx27MHBKiC5iKkpCydzHZABvhJjAB2uQxY//Y8r/+eqwj+2qVvbBYIs7wVML8xW4
         f6MqJECRgApeW5heRvNf/P2Ur+9OeY4PrqS2ZJmIHBnAOwEytAXtASUyTRUB89dySg
         WoIyNUSDWcmSIUEUxmTDZHcoDbVGPlO/v33G47F7zXm2+4icOUq8hqqqRqsem4a0NH
         Nr8TvKJn6pow19m4ug2zcSM+NrqFk2/LAi/UxQ4fDnkl8OPbM6nbBgy7+jDySyRbxw
         Gyr0Y7Zb+NcMhUFiYhSZ+4jG0jo5RLWf/2547WGXQsUd9aEPhduhkxZRtv7qguvPkp
         7AxrBA4E8fhdw==
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH] tools/lib/lockdep: drop liblockdep
Date:   Fri, 12 Nov 2021 10:16:02 -0500
Message-Id: <20211112151602.1378857-1-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TL;DR: While a tool like liblockdep is useful, it probably doesn't
belong within the kernel tree.

liblockdep attempts to reuse kernel code both directly (by directly
building the kernel's lockdep code) as well as indirectly (by using
sanitized headers). This makes liblockdep an integral part of the
kernel.

It also makes liblockdep quite unique: while other userspace code might
use sanitized headers, it generally doesn't attempt to use kernel code
directly which means that changes on the kernel side of things don't
affect (and break) it directly.

All our workflows and tooling around liblockdep don't support this
uniqueness. Changes that go into the kernel code aren't validated to not
break in-tree userspace code.

liblockdep ended up being very fragile, breaking over and over, to the
point that living in the same tree as the lockdep code lost most of it's
value.

liblockdep should continue living in an external tree, syncing with
the kernel often, in a controllable way.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 MAINTAINERS                                   |   5 -
 tools/Makefile                                |  16 +-
 tools/lib/lockdep/.gitignore                  |   2 -
 tools/lib/lockdep/Build                       |   1 -
 tools/lib/lockdep/Makefile                    | 162 -------
 tools/lib/lockdep/common.c                    |  29 --
 tools/lib/lockdep/include/liblockdep/common.h |  54 ---
 tools/lib/lockdep/include/liblockdep/mutex.h  |  73 ---
 tools/lib/lockdep/include/liblockdep/rwlock.h |  87 ----
 tools/lib/lockdep/lockdep                     |   3 -
 tools/lib/lockdep/lockdep.c                   |  33 --
 tools/lib/lockdep/lockdep_internals.h         |   1 -
 tools/lib/lockdep/lockdep_states.h            |   1 -
 tools/lib/lockdep/preload.c                   | 443 ------------------
 tools/lib/lockdep/rbtree.c                    |   1 -
 tools/lib/lockdep/run_tests.sh                |  47 --
 tools/lib/lockdep/tests/AA.c                  |  14 -
 tools/lib/lockdep/tests/AA.sh                 |   2 -
 tools/lib/lockdep/tests/ABA.c                 |  14 -
 tools/lib/lockdep/tests/ABA.sh                |   2 -
 tools/lib/lockdep/tests/ABBA.c                |  26 -
 tools/lib/lockdep/tests/ABBA.sh               |   2 -
 tools/lib/lockdep/tests/ABBA_2threads.c       |  47 --
 tools/lib/lockdep/tests/ABBA_2threads.sh      |   2 -
 tools/lib/lockdep/tests/ABBCCA.c              |  20 -
 tools/lib/lockdep/tests/ABBCCA.sh             |   2 -
 tools/lib/lockdep/tests/ABBCCDDA.c            |  23 -
 tools/lib/lockdep/tests/ABBCCDDA.sh           |   2 -
 tools/lib/lockdep/tests/ABCABC.c              |  20 -
 tools/lib/lockdep/tests/ABCABC.sh             |   2 -
 tools/lib/lockdep/tests/ABCDBCDA.c            |  23 -
 tools/lib/lockdep/tests/ABCDBCDA.sh           |   2 -
 tools/lib/lockdep/tests/ABCDBDDA.c            |  23 -
 tools/lib/lockdep/tests/ABCDBDDA.sh           |   2 -
 tools/lib/lockdep/tests/WW.c                  |  14 -
 tools/lib/lockdep/tests/WW.sh                 |   2 -
 tools/lib/lockdep/tests/common.h              |  13 -
 tools/lib/lockdep/tests/unlock_balance.c      |  15 -
 tools/lib/lockdep/tests/unlock_balance.sh     |   2 -
 39 files changed, 3 insertions(+), 1229 deletions(-)
 delete mode 100644 tools/lib/lockdep/.gitignore
 delete mode 100644 tools/lib/lockdep/Build
 delete mode 100644 tools/lib/lockdep/Makefile
 delete mode 100644 tools/lib/lockdep/common.c
 delete mode 100644 tools/lib/lockdep/include/liblockdep/common.h
 delete mode 100644 tools/lib/lockdep/include/liblockdep/mutex.h
 delete mode 100644 tools/lib/lockdep/include/liblockdep/rwlock.h
 delete mode 100755 tools/lib/lockdep/lockdep
 delete mode 100644 tools/lib/lockdep/lockdep.c
 delete mode 100644 tools/lib/lockdep/lockdep_internals.h
 delete mode 100644 tools/lib/lockdep/lockdep_states.h
 delete mode 100644 tools/lib/lockdep/preload.c
 delete mode 100644 tools/lib/lockdep/rbtree.c
 delete mode 100755 tools/lib/lockdep/run_tests.sh
 delete mode 100644 tools/lib/lockdep/tests/AA.c
 delete mode 100644 tools/lib/lockdep/tests/AA.sh
 delete mode 100644 tools/lib/lockdep/tests/ABA.c
 delete mode 100644 tools/lib/lockdep/tests/ABA.sh
 delete mode 100644 tools/lib/lockdep/tests/ABBA.c
 delete mode 100644 tools/lib/lockdep/tests/ABBA.sh
 delete mode 100644 tools/lib/lockdep/tests/ABBA_2threads.c
 delete mode 100644 tools/lib/lockdep/tests/ABBA_2threads.sh
 delete mode 100644 tools/lib/lockdep/tests/ABBCCA.c
 delete mode 100644 tools/lib/lockdep/tests/ABBCCA.sh
 delete mode 100644 tools/lib/lockdep/tests/ABBCCDDA.c
 delete mode 100644 tools/lib/lockdep/tests/ABBCCDDA.sh
 delete mode 100644 tools/lib/lockdep/tests/ABCABC.c
 delete mode 100644 tools/lib/lockdep/tests/ABCABC.sh
 delete mode 100644 tools/lib/lockdep/tests/ABCDBCDA.c
 delete mode 100644 tools/lib/lockdep/tests/ABCDBCDA.sh
 delete mode 100644 tools/lib/lockdep/tests/ABCDBDDA.c
 delete mode 100644 tools/lib/lockdep/tests/ABCDBDDA.sh
 delete mode 100644 tools/lib/lockdep/tests/WW.c
 delete mode 100644 tools/lib/lockdep/tests/WW.sh
 delete mode 100644 tools/lib/lockdep/tests/common.h
 delete mode 100644 tools/lib/lockdep/tests/unlock_balance.c
 delete mode 100644 tools/lib/lockdep/tests/unlock_balance.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd441dde8..ab67cb673015c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10648,11 +10648,6 @@ F:	drivers/ata/
 F:	include/linux/ata.h
 F:	include/linux/libata.h
 
-LIBLOCKDEP
-M:	Sasha Levin <alexander.levin@microsoft.com>
-S:	Maintained
-F:	tools/lib/lockdep/
-
 LIBNVDIMM BLK: MMIO-APERTURE DRIVER
 M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
diff --git a/tools/Makefile b/tools/Makefile
index 7e9d34ddd74c6..38f6243851408 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -23,7 +23,6 @@ help:
 	@echo '  intel-speed-select     - Intel Speed Select tool'
 	@echo '  kvm_stat               - top-like utility for displaying kvm statistics'
 	@echo '  leds                   - LEDs  tools'
-	@echo '  liblockdep             - user-space wrapper for kernel locking-validator'
 	@echo '  objtool                - an ELF object analysis tool'
 	@echo '  pci                    - PCI tools'
 	@echo '  perf                   - Linux performance measurement and analysis tool'
@@ -71,9 +70,6 @@ cgroup firewire hv guest bootconfig spi usb virtio vm bpf iio gpio objtool leds
 bpf/%: FORCE
 	$(call descend,$@)
 
-liblockdep: FORCE
-	$(call descend,lib/lockdep)
-
 libapi: FORCE
 	$(call descend,lib/api)
 
@@ -100,7 +96,7 @@ freefall: FORCE
 kvm_stat: FORCE
 	$(call descend,kvm/$@)
 
-all: acpi cgroup cpupower gpio hv firewire liblockdep \
+all: acpi cgroup cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio vm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
@@ -115,9 +111,6 @@ cpupower_install:
 cgroup_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
 	$(call descend,$(@:_install=),install)
 
-liblockdep_install:
-	$(call descend,lib/lockdep,install)
-
 selftests_install:
 	$(call descend,testing/$(@:_install=),install)
 
@@ -134,7 +127,7 @@ kvm_stat_install:
 	$(call descend,kvm/$(@:_install=),install)
 
 install: acpi_install cgroup_install cpupower_install gpio_install \
-		hv_install firewire_install iio_install liblockdep_install \
+		hv_install firewire_install iio_install \
 		perf_install selftests_install turbostat_install usb_install \
 		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
@@ -150,9 +143,6 @@ cpupower_clean:
 cgroup_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
 	$(call descend,$(@:_clean=),clean)
 
-liblockdep_clean:
-	$(call descend,lib/lockdep,clean)
-
 libapi_clean:
 	$(call descend,lib/api,clean)
 
@@ -184,7 +174,7 @@ build_clean:
 clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
-		freefall_clean build_clean libbpf_clean libsubcmd_clean liblockdep_clean \
+		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
 		intel-speed-select_clean tracing_clean
 
diff --git a/tools/lib/lockdep/.gitignore b/tools/lib/lockdep/.gitignore
deleted file mode 100644
index 6c308ac4388cf..0000000000000
--- a/tools/lib/lockdep/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-liblockdep.so.*
diff --git a/tools/lib/lockdep/Build b/tools/lib/lockdep/Build
deleted file mode 100644
index 6f667355b0687..0000000000000
--- a/tools/lib/lockdep/Build
+++ /dev/null
@@ -1 +0,0 @@
-liblockdep-y += common.o lockdep.o preload.o rbtree.o
diff --git a/tools/lib/lockdep/Makefile b/tools/lib/lockdep/Makefile
deleted file mode 100644
index 9dafb8cb752fe..0000000000000
--- a/tools/lib/lockdep/Makefile
+++ /dev/null
@@ -1,162 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# file format version
-FILE_VERSION = 1
-
-LIBLOCKDEP_VERSION=$(shell make --no-print-directory -sC ../../.. kernelversion)
-
-# Makefiles suck: This macro sets a default value of $(2) for the
-# variable named by $(1), unless the variable has been set by
-# environment or command line. This is necessary for CC and AR
-# because make sets default values, so the simpler ?= approach
-# won't work as expected.
-define allow-override
-  $(if $(or $(findstring environment,$(origin $(1))),\
-            $(findstring command line,$(origin $(1)))),,\
-    $(eval $(1) = $(2)))
-endef
-
-# Allow setting CC and AR and LD, or setting CROSS_COMPILE as a prefix.
-$(call allow-override,CC,$(CROSS_COMPILE)gcc)
-$(call allow-override,AR,$(CROSS_COMPILE)ar)
-$(call allow-override,LD,$(CROSS_COMPILE)ld)
-
-INSTALL = install
-
-# Use DESTDIR for installing into a different root directory.
-# This is useful for building a package. The program will be
-# installed in this directory as if it was the root directory.
-# Then the build tool can move it later.
-DESTDIR ?=
-DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
-
-prefix ?= /usr/local
-libdir_relative = lib
-libdir = $(prefix)/$(libdir_relative)
-bindir_relative = bin
-bindir = $(prefix)/$(bindir_relative)
-
-export DESTDIR DESTDIR_SQ INSTALL
-
-MAKEFLAGS += --no-print-directory
-
-include ../../scripts/Makefile.include
-
-# copy a bit from Linux kbuild
-
-ifeq ("$(origin V)", "command line")
-  VERBOSE = $(V)
-endif
-ifndef VERBOSE
-  VERBOSE = 0
-endif
-
-ifeq ($(srctree),)
-srctree := $(patsubst %/,%,$(dir $(CURDIR)))
-srctree := $(patsubst %/,%,$(dir $(srctree)))
-srctree := $(patsubst %/,%,$(dir $(srctree)))
-#$(info Determined 'srctree' to be $(srctree))
-endif
-
-# Shell quotes
-libdir_SQ = $(subst ','\'',$(libdir))
-bindir_SQ = $(subst ','\'',$(bindir))
-
-LIB_IN := $(OUTPUT)liblockdep-in.o
-
-BIN_FILE = lockdep
-LIB_FILE = $(OUTPUT)liblockdep.a $(OUTPUT)liblockdep.so.$(LIBLOCKDEP_VERSION)
-
-CONFIG_INCLUDES =
-CONFIG_LIBS	=
-CONFIG_FLAGS	=
-
-OBJ		= $@
-N		=
-
-export Q VERBOSE
-
-INCLUDES = -I. -I./uinclude -I./include -I../../include $(CONFIG_INCLUDES)
-
-# Set compile option CFLAGS if not set elsewhere
-CFLAGS ?= -g -DCONFIG_LOCKDEP -DCONFIG_STACKTRACE -DCONFIG_PROVE_LOCKING -DBITS_PER_LONG=__WORDSIZE -DLIBLOCKDEP_VERSION='"$(LIBLOCKDEP_VERSION)"' -rdynamic -O0 -g
-CFLAGS += -fPIC
-CFLAGS += -Wall
-
-override CFLAGS += $(CONFIG_FLAGS) $(INCLUDES) $(PLUGIN_DIR_SQ)
-
-ifeq ($(VERBOSE),1)
-  Q =
-  print_shared_lib_compile =
-  print_install =
-else
-  Q = @
-  print_shared_lib_compile =	echo '  LD       '$(OBJ);
-  print_static_lib_build =	echo '  LD       '$(OBJ);
-  print_install =		echo '  INSTALL  '$1'	to	$(DESTDIR_SQ)$2';
-endif
-
-all:
-
-export srctree OUTPUT CC LD CFLAGS V
-include $(srctree)/tools/build/Makefile.include
-
-do_compile_shared_library =			\
-	($(print_shared_lib_compile)		\
-	$(CC) $(LDFLAGS) --shared $^ -o $@ -lpthread -ldl -Wl,-soname='$(@F)';$(shell ln -sf $(@F) $(@D)/liblockdep.so))
-
-do_build_static_lib =				\
-	($(print_static_lib_build)		\
-	$(RM) $@;  $(AR) rcs $@ $^)
-
-CMD_TARGETS = $(LIB_FILE)
-
-TARGETS = $(CMD_TARGETS)
-
-
-all: fixdep all_cmd
-
-all_cmd: $(CMD_TARGETS)
-
-$(LIB_IN): force
-	$(Q)$(MAKE) $(build)=liblockdep
-
-$(OUTPUT)liblockdep.so.$(LIBLOCKDEP_VERSION): $(LIB_IN)
-	$(Q)$(do_compile_shared_library)
-
-$(OUTPUT)liblockdep.a: $(LIB_IN)
-	$(Q)$(do_build_static_lib)
-
-tags:	force
-	$(RM) tags
-	find . -name '*.[ch]' | xargs ctags --extra=+f --c-kinds=+px \
-	--regex-c++='/_PE\(([^,)]*).*/TEP_ERRNO__\1/'
-
-TAGS:	force
-	$(RM) TAGS
-	find . -name '*.[ch]' | xargs etags \
-	--regex='/_PE(\([^,)]*\).*/TEP_ERRNO__\1/'
-
-define do_install
-	$(print_install)				\
-	if [ ! -d '$(DESTDIR_SQ)$2' ]; then		\
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2';	\
-	fi;						\
-	$(INSTALL) $1 '$(DESTDIR_SQ)$2'
-endef
-
-install_lib: all_cmd
-	$(Q)$(call do_install,$(LIB_FILE),$(libdir_SQ))
-	$(Q)$(call do_install,$(BIN_FILE),$(bindir_SQ))
-
-install: install_lib
-
-clean:
-	$(RM) $(OUTPUT)*.o *~ $(TARGETS) $(OUTPUT)*.a $(OUTPUT)*liblockdep*.so* $(VERSION_FILES) $(OUTPUT).*.d $(OUTPUT).*.cmd
-	$(RM) tags TAGS
-
-PHONY += force
-force:
-
-# Declare the contents of the .PHONY variable as phony.  We keep that
-# information in a variable so we can use it in if_changed and friends.
-.PHONY: $(PHONY)
diff --git a/tools/lib/lockdep/common.c b/tools/lib/lockdep/common.c
deleted file mode 100644
index 5c3b58cce8a9b..0000000000000
--- a/tools/lib/lockdep/common.c
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stddef.h>
-#include <stdbool.h>
-#include <linux/compiler.h>
-#include <linux/lockdep.h>
-#include <unistd.h>
-#include <sys/syscall.h>
-
-static __thread struct task_struct current_obj;
-
-/* lockdep wants these */
-bool debug_locks = true;
-bool debug_locks_silent;
-
-__attribute__((destructor)) static void liblockdep_exit(void)
-{
-	debug_check_no_locks_held();
-}
-
-struct task_struct *__curr(void)
-{
-	if (current_obj.pid == 0) {
-		/* Makes lockdep output pretty */
-		prctl(PR_GET_NAME, current_obj.comm);
-		current_obj.pid = syscall(__NR_gettid);
-	}
-
-	return &current_obj;
-}
diff --git a/tools/lib/lockdep/include/liblockdep/common.h b/tools/lib/lockdep/include/liblockdep/common.h
deleted file mode 100644
index a6d7ee5f18ba9..0000000000000
--- a/tools/lib/lockdep/include/liblockdep/common.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LIBLOCKDEP_COMMON_H
-#define _LIBLOCKDEP_COMMON_H
-
-#include <pthread.h>
-
-#define NR_LOCKDEP_CACHING_CLASSES 2
-#define MAX_LOCKDEP_SUBCLASSES 8UL
-
-#ifndef CALLER_ADDR0
-#define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
-#endif
-
-#ifndef _RET_IP_
-#define _RET_IP_ CALLER_ADDR0
-#endif
-
-#ifndef _THIS_IP_
-#define _THIS_IP_ ({ __label__ __here; __here: (unsigned long)&&__here; })
-#endif
-
-struct lockdep_subclass_key {
-	char __one_byte;
-};
-
-struct lock_class_key {
-	struct lockdep_subclass_key subkeys[MAX_LOCKDEP_SUBCLASSES];
-};
-
-struct lockdep_map {
-	struct lock_class_key	*key;
-	struct lock_class	*class_cache[NR_LOCKDEP_CACHING_CLASSES];
-	const char		*name;
-#ifdef CONFIG_LOCK_STAT
-	int			cpu;
-	unsigned long		ip;
-#endif
-};
-
-void lockdep_init_map(struct lockdep_map *lock, const char *name,
-			struct lock_class_key *key, int subclass);
-void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
-			int trylock, int read, int check,
-			struct lockdep_map *nest_lock, unsigned long ip);
-void lock_release(struct lockdep_map *lock, unsigned long ip);
-void lockdep_reset_lock(struct lockdep_map *lock);
-void lockdep_register_key(struct lock_class_key *key);
-void lockdep_unregister_key(struct lock_class_key *key);
-extern void debug_check_no_locks_freed(const void *from, unsigned long len);
-
-#define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
-	{ .name = (_name), .key = (void *)(_key), }
-
-#endif
diff --git a/tools/lib/lockdep/include/liblockdep/mutex.h b/tools/lib/lockdep/include/liblockdep/mutex.h
deleted file mode 100644
index bd106b82759b7..0000000000000
--- a/tools/lib/lockdep/include/liblockdep/mutex.h
+++ /dev/null
@@ -1,73 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LIBLOCKDEP_MUTEX_H
-#define _LIBLOCKDEP_MUTEX_H
-
-#include <pthread.h>
-#include "common.h"
-
-struct liblockdep_pthread_mutex {
-	pthread_mutex_t mutex;
-	struct lock_class_key key;
-	struct lockdep_map dep_map;
-};
-
-typedef struct liblockdep_pthread_mutex liblockdep_pthread_mutex_t;
-
-#define LIBLOCKDEP_PTHREAD_MUTEX_INITIALIZER(mtx)			\
-		(const struct liblockdep_pthread_mutex) {		\
-	.mutex = PTHREAD_MUTEX_INITIALIZER,				\
-	.dep_map = STATIC_LOCKDEP_MAP_INIT(#mtx, &((&(mtx))->dep_map)),	\
-}
-
-static inline int __mutex_init(liblockdep_pthread_mutex_t *lock,
-				const char *name,
-				struct lock_class_key *key,
-				const pthread_mutexattr_t *__mutexattr)
-{
-	lockdep_init_map(&lock->dep_map, name, key, 0);
-	return pthread_mutex_init(&lock->mutex, __mutexattr);
-}
-
-#define liblockdep_pthread_mutex_init(mutex, mutexattr)			\
-({									\
-	lockdep_register_key(&(mutex)->key);				\
-	__mutex_init((mutex), #mutex, &(mutex)->key, (mutexattr));	\
-})
-
-static inline int liblockdep_pthread_mutex_lock(liblockdep_pthread_mutex_t *lock)
-{
-	lock_acquire(&lock->dep_map, 0, 0, 0, 1, NULL, (unsigned long)_RET_IP_);
-	return pthread_mutex_lock(&lock->mutex);
-}
-
-static inline int liblockdep_pthread_mutex_unlock(liblockdep_pthread_mutex_t *lock)
-{
-	lock_release(&lock->dep_map, (unsigned long)_RET_IP_);
-	return pthread_mutex_unlock(&lock->mutex);
-}
-
-static inline int liblockdep_pthread_mutex_trylock(liblockdep_pthread_mutex_t *lock)
-{
-	lock_acquire(&lock->dep_map, 0, 1, 0, 1, NULL, (unsigned long)_RET_IP_);
-	return pthread_mutex_trylock(&lock->mutex) == 0 ? 1 : 0;
-}
-
-static inline int liblockdep_pthread_mutex_destroy(liblockdep_pthread_mutex_t *lock)
-{
-	lockdep_reset_lock(&lock->dep_map);
-	lockdep_unregister_key(&lock->key);
-	return pthread_mutex_destroy(&lock->mutex);
-}
-
-#ifdef __USE_LIBLOCKDEP
-
-#define pthread_mutex_t         liblockdep_pthread_mutex_t
-#define pthread_mutex_init      liblockdep_pthread_mutex_init
-#define pthread_mutex_lock      liblockdep_pthread_mutex_lock
-#define pthread_mutex_unlock    liblockdep_pthread_mutex_unlock
-#define pthread_mutex_trylock   liblockdep_pthread_mutex_trylock
-#define pthread_mutex_destroy   liblockdep_pthread_mutex_destroy
-
-#endif
-
-#endif
diff --git a/tools/lib/lockdep/include/liblockdep/rwlock.h b/tools/lib/lockdep/include/liblockdep/rwlock.h
deleted file mode 100644
index 6d5d2932bf4d9..0000000000000
--- a/tools/lib/lockdep/include/liblockdep/rwlock.h
+++ /dev/null
@@ -1,87 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LIBLOCKDEP_RWLOCK_H
-#define _LIBLOCKDEP_RWLOCK_H
-
-#include <pthread.h>
-#include "common.h"
-
-struct liblockdep_pthread_rwlock {
-	pthread_rwlock_t rwlock;
-	struct lockdep_map dep_map;
-};
-
-typedef struct liblockdep_pthread_rwlock liblockdep_pthread_rwlock_t;
-
-#define LIBLOCKDEP_PTHREAD_RWLOCK_INITIALIZER(rwl)			\
-		(struct liblockdep_pthread_rwlock) {			\
-	.rwlock = PTHREAD_RWLOCK_INITIALIZER,				\
-	.dep_map = STATIC_LOCKDEP_MAP_INIT(#rwl, &((&(rwl))->dep_map)),	\
-}
-
-static inline int __rwlock_init(liblockdep_pthread_rwlock_t *lock,
-				const char *name,
-				struct lock_class_key *key,
-				const pthread_rwlockattr_t *attr)
-{
-	lockdep_init_map(&lock->dep_map, name, key, 0);
-
-	return pthread_rwlock_init(&lock->rwlock, attr);
-}
-
-#define liblockdep_pthread_rwlock_init(lock, attr)		\
-({							\
-	static struct lock_class_key __key;		\
-							\
-	__rwlock_init((lock), #lock, &__key, (attr));	\
-})
-
-static inline int liblockdep_pthread_rwlock_rdlock(liblockdep_pthread_rwlock_t *lock)
-{
-	lock_acquire(&lock->dep_map, 0, 0, 2, 1, NULL, (unsigned long)_RET_IP_);
-	return pthread_rwlock_rdlock(&lock->rwlock);
-
-}
-
-static inline int liblockdep_pthread_rwlock_unlock(liblockdep_pthread_rwlock_t *lock)
-{
-	lock_release(&lock->dep_map, (unsigned long)_RET_IP_);
-	return pthread_rwlock_unlock(&lock->rwlock);
-}
-
-static inline int liblockdep_pthread_rwlock_wrlock(liblockdep_pthread_rwlock_t *lock)
-{
-	lock_acquire(&lock->dep_map, 0, 0, 0, 1, NULL, (unsigned long)_RET_IP_);
-	return pthread_rwlock_wrlock(&lock->rwlock);
-}
-
-static inline int liblockdep_pthread_rwlock_tryrdlock(liblockdep_pthread_rwlock_t *lock)
-{
-	lock_acquire(&lock->dep_map, 0, 1, 2, 1, NULL, (unsigned long)_RET_IP_);
-	return pthread_rwlock_tryrdlock(&lock->rwlock) == 0 ? 1 : 0;
-}
-
-static inline int liblockdep_pthread_rwlock_trywrlock(liblockdep_pthread_rwlock_t *lock)
-{
-	lock_acquire(&lock->dep_map, 0, 1, 0, 1, NULL, (unsigned long)_RET_IP_);
-	return pthread_rwlock_trywrlock(&lock->rwlock) == 0 ? 1 : 0;
-}
-
-static inline int liblockdep_rwlock_destroy(liblockdep_pthread_rwlock_t *lock)
-{
-	return pthread_rwlock_destroy(&lock->rwlock);
-}
-
-#ifdef __USE_LIBLOCKDEP
-
-#define pthread_rwlock_t		liblockdep_pthread_rwlock_t
-#define pthread_rwlock_init		liblockdep_pthread_rwlock_init
-#define pthread_rwlock_rdlock		liblockdep_pthread_rwlock_rdlock
-#define pthread_rwlock_unlock		liblockdep_pthread_rwlock_unlock
-#define pthread_rwlock_wrlock		liblockdep_pthread_rwlock_wrlock
-#define pthread_rwlock_tryrdlock	liblockdep_pthread_rwlock_tryrdlock
-#define pthread_rwlock_trywrlock	liblockdep_pthread_rwlock_trywrlock
-#define pthread_rwlock_destroy		liblockdep_rwlock_destroy
-
-#endif
-
-#endif
diff --git a/tools/lib/lockdep/lockdep b/tools/lib/lockdep/lockdep
deleted file mode 100755
index 49af9fe19f5b0..0000000000000
--- a/tools/lib/lockdep/lockdep
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-
-LD_PRELOAD="./liblockdep.so $LD_PRELOAD" "$@"
diff --git a/tools/lib/lockdep/lockdep.c b/tools/lib/lockdep/lockdep.c
deleted file mode 100644
index 348a9d0fb766a..0000000000000
--- a/tools/lib/lockdep/lockdep.c
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/lockdep.h>
-#include <stdlib.h>
-
-/* Trivial API wrappers, we don't (yet) have RCU in user-space: */
-#define hlist_for_each_entry_rcu	hlist_for_each_entry
-#define hlist_add_head_rcu		hlist_add_head
-#define hlist_del_rcu			hlist_del
-#define list_for_each_entry_rcu		list_for_each_entry
-#define list_add_tail_rcu		list_add_tail
-
-u32 prandom_u32(void)
-{
-	/* Used only by lock_pin_lock() which is dead code */
-	abort();
-}
-
-void print_irqtrace_events(struct task_struct *curr)
-{
-	abort();
-}
-
-static struct new_utsname *init_utsname(void)
-{
-	static struct new_utsname n = (struct new_utsname) {
-		.release = "liblockdep",
-		.version = LIBLOCKDEP_VERSION,
-	};
-
-	return &n;
-}
-
-#include "../../../kernel/locking/lockdep.c"
diff --git a/tools/lib/lockdep/lockdep_internals.h b/tools/lib/lockdep/lockdep_internals.h
deleted file mode 100644
index 29d0c954cc24a..0000000000000
--- a/tools/lib/lockdep/lockdep_internals.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../../../kernel/locking/lockdep_internals.h"
diff --git a/tools/lib/lockdep/lockdep_states.h b/tools/lib/lockdep/lockdep_states.h
deleted file mode 100644
index 248d235efda92..0000000000000
--- a/tools/lib/lockdep/lockdep_states.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../../../kernel/locking/lockdep_states.h"
diff --git a/tools/lib/lockdep/preload.c b/tools/lib/lockdep/preload.c
deleted file mode 100644
index 8f1adbe887b2f..0000000000000
--- a/tools/lib/lockdep/preload.c
+++ /dev/null
@@ -1,443 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-#include <pthread.h>
-#include <stdio.h>
-#include <dlfcn.h>
-#include <stdlib.h>
-#include <sysexits.h>
-#include <unistd.h>
-#include "include/liblockdep/mutex.h"
-#include "../../include/linux/rbtree.h"
-
-/**
- * struct lock_lookup - liblockdep's view of a single unique lock
- * @orig: pointer to the original pthread lock, used for lookups
- * @dep_map: lockdep's dep_map structure
- * @key: lockdep's key structure
- * @node: rb-tree node used to store the lock in a global tree
- * @name: a unique name for the lock
- */
-struct lock_lookup {
-	void *orig; /* Original pthread lock, used for lookups */
-	struct lockdep_map dep_map; /* Since all locks are dynamic, we need
-				     * a dep_map and a key for each lock */
-	/*
-	 * Wait, there's no support for key classes? Yup :(
-	 * Most big projects wrap the pthread api with their own calls to
-	 * be compatible with different locking methods. This means that
-	 * "classes" will be brokes since the function that creates all
-	 * locks will point to a generic locking function instead of the
-	 * actual code that wants to do the locking.
-	 */
-	struct lock_class_key key;
-	struct rb_node node;
-#define LIBLOCKDEP_MAX_LOCK_NAME 22
-	char name[LIBLOCKDEP_MAX_LOCK_NAME];
-};
-
-/* This is where we store our locks */
-static struct rb_root locks = RB_ROOT;
-static pthread_rwlock_t locks_rwlock = PTHREAD_RWLOCK_INITIALIZER;
-
-/* pthread mutex API */
-
-#ifdef __GLIBC__
-extern int __pthread_mutex_init(pthread_mutex_t *mutex, const pthread_mutexattr_t *attr);
-extern int __pthread_mutex_lock(pthread_mutex_t *mutex);
-extern int __pthread_mutex_trylock(pthread_mutex_t *mutex);
-extern int __pthread_mutex_unlock(pthread_mutex_t *mutex);
-extern int __pthread_mutex_destroy(pthread_mutex_t *mutex);
-#else
-#define __pthread_mutex_init	NULL
-#define __pthread_mutex_lock	NULL
-#define __pthread_mutex_trylock	NULL
-#define __pthread_mutex_unlock	NULL
-#define __pthread_mutex_destroy	NULL
-#endif
-static int (*ll_pthread_mutex_init)(pthread_mutex_t *mutex,
-			const pthread_mutexattr_t *attr)	= __pthread_mutex_init;
-static int (*ll_pthread_mutex_lock)(pthread_mutex_t *mutex)	= __pthread_mutex_lock;
-static int (*ll_pthread_mutex_trylock)(pthread_mutex_t *mutex)	= __pthread_mutex_trylock;
-static int (*ll_pthread_mutex_unlock)(pthread_mutex_t *mutex)	= __pthread_mutex_unlock;
-static int (*ll_pthread_mutex_destroy)(pthread_mutex_t *mutex)	= __pthread_mutex_destroy;
-
-/* pthread rwlock API */
-
-#ifdef __GLIBC__
-extern int __pthread_rwlock_init(pthread_rwlock_t *rwlock, const pthread_rwlockattr_t *attr);
-extern int __pthread_rwlock_destroy(pthread_rwlock_t *rwlock);
-extern int __pthread_rwlock_wrlock(pthread_rwlock_t *rwlock);
-extern int __pthread_rwlock_trywrlock(pthread_rwlock_t *rwlock);
-extern int __pthread_rwlock_rdlock(pthread_rwlock_t *rwlock);
-extern int __pthread_rwlock_tryrdlock(pthread_rwlock_t *rwlock);
-extern int __pthread_rwlock_unlock(pthread_rwlock_t *rwlock);
-#else
-#define __pthread_rwlock_init		NULL
-#define __pthread_rwlock_destroy	NULL
-#define __pthread_rwlock_wrlock		NULL
-#define __pthread_rwlock_trywrlock	NULL
-#define __pthread_rwlock_rdlock		NULL
-#define __pthread_rwlock_tryrdlock	NULL
-#define __pthread_rwlock_unlock		NULL
-#endif
-
-static int (*ll_pthread_rwlock_init)(pthread_rwlock_t *rwlock,
-			const pthread_rwlockattr_t *attr)		= __pthread_rwlock_init;
-static int (*ll_pthread_rwlock_destroy)(pthread_rwlock_t *rwlock)	= __pthread_rwlock_destroy;
-static int (*ll_pthread_rwlock_rdlock)(pthread_rwlock_t *rwlock)	= __pthread_rwlock_rdlock;
-static int (*ll_pthread_rwlock_tryrdlock)(pthread_rwlock_t *rwlock)	= __pthread_rwlock_tryrdlock;
-static int (*ll_pthread_rwlock_trywrlock)(pthread_rwlock_t *rwlock)	= __pthread_rwlock_trywrlock;
-static int (*ll_pthread_rwlock_wrlock)(pthread_rwlock_t *rwlock)	= __pthread_rwlock_wrlock;
-static int (*ll_pthread_rwlock_unlock)(pthread_rwlock_t *rwlock)	= __pthread_rwlock_unlock;
-
-enum { none, prepare, done, } __init_state;
-static void init_preload(void);
-static void try_init_preload(void)
-{
-	if (__init_state != done)
-		init_preload();
-}
-
-static struct rb_node **__get_lock_node(void *lock, struct rb_node **parent)
-{
-	struct rb_node **node = &locks.rb_node;
-	struct lock_lookup *l;
-
-	*parent = NULL;
-
-	while (*node) {
-		l = rb_entry(*node, struct lock_lookup, node);
-
-		*parent = *node;
-		if (lock < l->orig)
-			node = &l->node.rb_left;
-		else if (lock > l->orig)
-			node = &l->node.rb_right;
-		else
-			return node;
-	}
-
-	return node;
-}
-
-#ifndef LIBLOCKDEP_STATIC_ENTRIES
-#define LIBLOCKDEP_STATIC_ENTRIES	1024
-#endif
-
-static struct lock_lookup __locks[LIBLOCKDEP_STATIC_ENTRIES];
-static int __locks_nr;
-
-static inline bool is_static_lock(struct lock_lookup *lock)
-{
-	return lock >= __locks && lock < __locks + ARRAY_SIZE(__locks);
-}
-
-static struct lock_lookup *alloc_lock(void)
-{
-	if (__init_state != done) {
-		/*
-		 * Some programs attempt to initialize and use locks in their
-		 * allocation path. This means that a call to malloc() would
-		 * result in locks being initialized and locked.
-		 *
-		 * Why is it an issue for us? dlsym() below will try allocating
-		 * to give us the original function. Since this allocation will
-		 * result in a locking operations, we have to let pthread deal
-		 * with it, but we can't! we don't have the pointer to the
-		 * original API since we're inside dlsym() trying to get it
-		 */
-
-		int idx = __locks_nr++;
-		if (idx >= ARRAY_SIZE(__locks)) {
-			dprintf(STDERR_FILENO,
-		"LOCKDEP error: insufficient LIBLOCKDEP_STATIC_ENTRIES\n");
-			exit(EX_UNAVAILABLE);
-		}
-		return __locks + idx;
-	}
-
-	return malloc(sizeof(struct lock_lookup));
-}
-
-static inline void free_lock(struct lock_lookup *lock)
-{
-	if (likely(!is_static_lock(lock)))
-		free(lock);
-}
-
-/**
- * __get_lock - find or create a lock instance
- * @lock: pointer to a pthread lock function
- *
- * Try to find an existing lock in the rbtree using the provided pointer. If
- * one wasn't found - create it.
- */
-static struct lock_lookup *__get_lock(void *lock)
-{
-	struct rb_node **node, *parent;
-	struct lock_lookup *l;
-
-	ll_pthread_rwlock_rdlock(&locks_rwlock);
-	node = __get_lock_node(lock, &parent);
-	ll_pthread_rwlock_unlock(&locks_rwlock);
-	if (*node) {
-		return rb_entry(*node, struct lock_lookup, node);
-	}
-
-	/* We didn't find the lock, let's create it */
-	l = alloc_lock();
-	if (l == NULL)
-		return NULL;
-
-	l->orig = lock;
-	/*
-	 * Currently the name of the lock is the ptr value of the pthread lock,
-	 * while not optimal, it makes debugging a bit easier.
-	 *
-	 * TODO: Get the real name of the lock using libdwarf
-	 */
-	sprintf(l->name, "%p", lock);
-	lockdep_init_map(&l->dep_map, l->name, &l->key, 0);
-
-	ll_pthread_rwlock_wrlock(&locks_rwlock);
-	/* This might have changed since the last time we fetched it */
-	node = __get_lock_node(lock, &parent);
-	rb_link_node(&l->node, parent, node);
-	rb_insert_color(&l->node, &locks);
-	ll_pthread_rwlock_unlock(&locks_rwlock);
-
-	return l;
-}
-
-static void __del_lock(struct lock_lookup *lock)
-{
-	ll_pthread_rwlock_wrlock(&locks_rwlock);
-	rb_erase(&lock->node, &locks);
-	ll_pthread_rwlock_unlock(&locks_rwlock);
-	free_lock(lock);
-}
-
-int pthread_mutex_init(pthread_mutex_t *mutex,
-			const pthread_mutexattr_t *attr)
-{
-	int r;
-
-	/*
-	 * We keep trying to init our preload module because there might be
-	 * code in init sections that tries to touch locks before we are
-	 * initialized, in that case we'll need to manually call preload
-	 * to get us going.
-	 *
-	 * Funny enough, kernel's lockdep had the same issue, and used
-	 * (almost) the same solution. See look_up_lock_class() in
-	 * kernel/locking/lockdep.c for details.
-	 */
-	try_init_preload();
-
-	r = ll_pthread_mutex_init(mutex, attr);
-	if (r == 0)
-		/*
-		 * We do a dummy initialization here so that lockdep could
-		 * warn us if something fishy is going on - such as
-		 * initializing a held lock.
-		 */
-		__get_lock(mutex);
-
-	return r;
-}
-
-int pthread_mutex_lock(pthread_mutex_t *mutex)
-{
-	int r;
-
-	try_init_preload();
-
-	lock_acquire(&__get_lock(mutex)->dep_map, 0, 0, 0, 1, NULL,
-			(unsigned long)_RET_IP_);
-	/*
-	 * Here's the thing with pthread mutexes: unlike the kernel variant,
-	 * they can fail.
-	 *
-	 * This means that the behaviour here is a bit different from what's
-	 * going on in the kernel: there we just tell lockdep that we took the
-	 * lock before actually taking it, but here we must deal with the case
-	 * that locking failed.
-	 *
-	 * To do that we'll "release" the lock if locking failed - this way
-	 * we'll get lockdep doing the correct checks when we try to take
-	 * the lock, and if that fails - we'll be back to the correct
-	 * state by releasing it.
-	 */
-	r = ll_pthread_mutex_lock(mutex);
-	if (r)
-		lock_release(&__get_lock(mutex)->dep_map, (unsigned long)_RET_IP_);
-
-	return r;
-}
-
-int pthread_mutex_trylock(pthread_mutex_t *mutex)
-{
-	int r;
-
-	try_init_preload();
-
-	lock_acquire(&__get_lock(mutex)->dep_map, 0, 1, 0, 1, NULL, (unsigned long)_RET_IP_);
-	r = ll_pthread_mutex_trylock(mutex);
-	if (r)
-		lock_release(&__get_lock(mutex)->dep_map, (unsigned long)_RET_IP_);
-
-	return r;
-}
-
-int pthread_mutex_unlock(pthread_mutex_t *mutex)
-{
-	int r;
-
-	try_init_preload();
-
-	lock_release(&__get_lock(mutex)->dep_map, (unsigned long)_RET_IP_);
-	/*
-	 * Just like taking a lock, only in reverse!
-	 *
-	 * If we fail releasing the lock, tell lockdep we're holding it again.
-	 */
-	r = ll_pthread_mutex_unlock(mutex);
-	if (r)
-		lock_acquire(&__get_lock(mutex)->dep_map, 0, 0, 0, 1, NULL, (unsigned long)_RET_IP_);
-
-	return r;
-}
-
-int pthread_mutex_destroy(pthread_mutex_t *mutex)
-{
-	try_init_preload();
-
-	/*
-	 * Let's see if we're releasing a lock that's held.
-	 *
-	 * TODO: Hook into free() and add that check there as well.
-	 */
-	debug_check_no_locks_freed(mutex, sizeof(*mutex));
-	__del_lock(__get_lock(mutex));
-	return ll_pthread_mutex_destroy(mutex);
-}
-
-/* This is the rwlock part, very similar to what happened with mutex above */
-int pthread_rwlock_init(pthread_rwlock_t *rwlock,
-			const pthread_rwlockattr_t *attr)
-{
-	int r;
-
-	try_init_preload();
-
-	r = ll_pthread_rwlock_init(rwlock, attr);
-	if (r == 0)
-		__get_lock(rwlock);
-
-	return r;
-}
-
-int pthread_rwlock_destroy(pthread_rwlock_t *rwlock)
-{
-	try_init_preload();
-
-	debug_check_no_locks_freed(rwlock, sizeof(*rwlock));
-	__del_lock(__get_lock(rwlock));
-	return ll_pthread_rwlock_destroy(rwlock);
-}
-
-int pthread_rwlock_rdlock(pthread_rwlock_t *rwlock)
-{
-	int r;
-
-        init_preload();
-
-	lock_acquire(&__get_lock(rwlock)->dep_map, 0, 0, 2, 1, NULL, (unsigned long)_RET_IP_);
-	r = ll_pthread_rwlock_rdlock(rwlock);
-	if (r)
-		lock_release(&__get_lock(rwlock)->dep_map, (unsigned long)_RET_IP_);
-
-	return r;
-}
-
-int pthread_rwlock_tryrdlock(pthread_rwlock_t *rwlock)
-{
-	int r;
-
-        init_preload();
-
-	lock_acquire(&__get_lock(rwlock)->dep_map, 0, 1, 2, 1, NULL, (unsigned long)_RET_IP_);
-	r = ll_pthread_rwlock_tryrdlock(rwlock);
-	if (r)
-		lock_release(&__get_lock(rwlock)->dep_map, (unsigned long)_RET_IP_);
-
-	return r;
-}
-
-int pthread_rwlock_trywrlock(pthread_rwlock_t *rwlock)
-{
-	int r;
-
-        init_preload();
-
-	lock_acquire(&__get_lock(rwlock)->dep_map, 0, 1, 0, 1, NULL, (unsigned long)_RET_IP_);
-	r = ll_pthread_rwlock_trywrlock(rwlock);
-	if (r)
-		lock_release(&__get_lock(rwlock)->dep_map, (unsigned long)_RET_IP_);
-
-	return r;
-}
-
-int pthread_rwlock_wrlock(pthread_rwlock_t *rwlock)
-{
-	int r;
-
-        init_preload();
-
-	lock_acquire(&__get_lock(rwlock)->dep_map, 0, 0, 0, 1, NULL, (unsigned long)_RET_IP_);
-	r = ll_pthread_rwlock_wrlock(rwlock);
-	if (r)
-		lock_release(&__get_lock(rwlock)->dep_map, (unsigned long)_RET_IP_);
-
-	return r;
-}
-
-int pthread_rwlock_unlock(pthread_rwlock_t *rwlock)
-{
-	int r;
-
-        init_preload();
-
-	lock_release(&__get_lock(rwlock)->dep_map, (unsigned long)_RET_IP_);
-	r = ll_pthread_rwlock_unlock(rwlock);
-	if (r)
-		lock_acquire(&__get_lock(rwlock)->dep_map, 0, 0, 0, 1, NULL, (unsigned long)_RET_IP_);
-
-	return r;
-}
-
-__attribute__((constructor)) static void init_preload(void)
-{
-	if (__init_state == done)
-		return;
-
-#ifndef __GLIBC__
-	__init_state = prepare;
-
-	ll_pthread_mutex_init = dlsym(RTLD_NEXT, "pthread_mutex_init");
-	ll_pthread_mutex_lock = dlsym(RTLD_NEXT, "pthread_mutex_lock");
-	ll_pthread_mutex_trylock = dlsym(RTLD_NEXT, "pthread_mutex_trylock");
-	ll_pthread_mutex_unlock = dlsym(RTLD_NEXT, "pthread_mutex_unlock");
-	ll_pthread_mutex_destroy = dlsym(RTLD_NEXT, "pthread_mutex_destroy");
-
-	ll_pthread_rwlock_init = dlsym(RTLD_NEXT, "pthread_rwlock_init");
-	ll_pthread_rwlock_destroy = dlsym(RTLD_NEXT, "pthread_rwlock_destroy");
-	ll_pthread_rwlock_rdlock = dlsym(RTLD_NEXT, "pthread_rwlock_rdlock");
-	ll_pthread_rwlock_tryrdlock = dlsym(RTLD_NEXT, "pthread_rwlock_tryrdlock");
-	ll_pthread_rwlock_wrlock = dlsym(RTLD_NEXT, "pthread_rwlock_wrlock");
-	ll_pthread_rwlock_trywrlock = dlsym(RTLD_NEXT, "pthread_rwlock_trywrlock");
-	ll_pthread_rwlock_unlock = dlsym(RTLD_NEXT, "pthread_rwlock_unlock");
-#endif
-
-	__init_state = done;
-}
diff --git a/tools/lib/lockdep/rbtree.c b/tools/lib/lockdep/rbtree.c
deleted file mode 100644
index 297c304571f8b..0000000000000
--- a/tools/lib/lockdep/rbtree.c
+++ /dev/null
@@ -1 +0,0 @@
-#include "../../lib/rbtree.c"
diff --git a/tools/lib/lockdep/run_tests.sh b/tools/lib/lockdep/run_tests.sh
deleted file mode 100755
index 11f425662b432..0000000000000
--- a/tools/lib/lockdep/run_tests.sh
+++ /dev/null
@@ -1,47 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-if ! make >/dev/null; then
-    echo "Building liblockdep failed."
-    echo "FAILED!"
-    exit 1
-fi
-
-find tests -name '*.c' | sort | while read -r i; do
-	testname=$(basename "$i" .c)
-	echo -ne "$testname... "
-	if gcc -o "tests/$testname" -pthread "$i" liblockdep.a -Iinclude -D__USE_LIBLOCKDEP &&
-		timeout 1 "tests/$testname" 2>&1 | /bin/bash "tests/${testname}.sh"; then
-		echo "PASSED!"
-	else
-		echo "FAILED!"
-	fi
-	rm -f "tests/$testname"
-done
-
-find tests -name '*.c' | sort | while read -r i; do
-	testname=$(basename "$i" .c)
-	echo -ne "(PRELOAD) $testname... "
-	if gcc -o "tests/$testname" -pthread -Iinclude "$i" &&
-		timeout 1 ./lockdep "tests/$testname" 2>&1 |
-		/bin/bash "tests/${testname}.sh"; then
-		echo "PASSED!"
-	else
-		echo "FAILED!"
-	fi
-	rm -f "tests/$testname"
-done
-
-find tests -name '*.c' | sort | while read -r i; do
-	testname=$(basename "$i" .c)
-	echo -ne "(PRELOAD + Valgrind) $testname... "
-	if gcc -o "tests/$testname" -pthread -Iinclude "$i" &&
-		{ timeout 10 valgrind --read-var-info=yes ./lockdep "./tests/$testname" >& "tests/${testname}.vg.out"; true; } &&
-		/bin/bash "tests/${testname}.sh" < "tests/${testname}.vg.out" &&
-		! grep -Eq '(^==[0-9]*== (Invalid |Uninitialised ))|Mismatched free|Source and destination overlap| UME ' "tests/${testname}.vg.out"; then
-		echo "PASSED!"
-	else
-		echo "FAILED!"
-	fi
-	rm -f "tests/$testname"
-done
diff --git a/tools/lib/lockdep/tests/AA.c b/tools/lib/lockdep/tests/AA.c
deleted file mode 100644
index 63c7ce97bda3a..0000000000000
--- a/tools/lib/lockdep/tests/AA.c
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <liblockdep/mutex.h>
-
-int main(void)
-{
-	pthread_mutex_t a;
-
-	pthread_mutex_init(&a, NULL);
-
-	pthread_mutex_lock(&a);
-	pthread_mutex_lock(&a);
-
-	return 0;
-}
diff --git a/tools/lib/lockdep/tests/AA.sh b/tools/lib/lockdep/tests/AA.sh
deleted file mode 100644
index f39b328650741..0000000000000
--- a/tools/lib/lockdep/tests/AA.sh
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-grep -q 'WARNING: possible recursive locking detected'
diff --git a/tools/lib/lockdep/tests/ABA.c b/tools/lib/lockdep/tests/ABA.c
deleted file mode 100644
index efa39b23f05d0..0000000000000
--- a/tools/lib/lockdep/tests/ABA.c
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <liblockdep/mutex.h>
-
-void main(void)
-{
-	pthread_mutex_t a, b;
-
-	pthread_mutex_init(&a, NULL);
-	pthread_mutex_init(&b, NULL);
-
-	pthread_mutex_lock(&a);
-	pthread_mutex_lock(&b);
-	pthread_mutex_lock(&a);
-}
diff --git a/tools/lib/lockdep/tests/ABA.sh b/tools/lib/lockdep/tests/ABA.sh
deleted file mode 100644
index f39b328650741..0000000000000
--- a/tools/lib/lockdep/tests/ABA.sh
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-grep -q 'WARNING: possible recursive locking detected'
diff --git a/tools/lib/lockdep/tests/ABBA.c b/tools/lib/lockdep/tests/ABBA.c
deleted file mode 100644
index 543789bc3e375..0000000000000
--- a/tools/lib/lockdep/tests/ABBA.c
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <liblockdep/mutex.h>
-#include "common.h"
-
-void main(void)
-{
-	pthread_mutex_t a, b;
-
-	pthread_mutex_init(&a, NULL);
-	pthread_mutex_init(&b, NULL);
-
-	LOCK_UNLOCK_2(a, b);
-	LOCK_UNLOCK_2(b, a);
-
-	pthread_mutex_destroy(&b);
-	pthread_mutex_destroy(&a);
-
-	pthread_mutex_init(&a, NULL);
-	pthread_mutex_init(&b, NULL);
-
-	LOCK_UNLOCK_2(a, b);
-	LOCK_UNLOCK_2(b, a);
-
-	pthread_mutex_destroy(&b);
-	pthread_mutex_destroy(&a);
-}
diff --git a/tools/lib/lockdep/tests/ABBA.sh b/tools/lib/lockdep/tests/ABBA.sh
deleted file mode 100644
index fc31c607a5a8b..0000000000000
--- a/tools/lib/lockdep/tests/ABBA.sh
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABBA_2threads.c b/tools/lib/lockdep/tests/ABBA_2threads.c
deleted file mode 100644
index 39325ef8a2ac1..0000000000000
--- a/tools/lib/lockdep/tests/ABBA_2threads.c
+++ /dev/null
@@ -1,47 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <pthread.h>
-
-pthread_mutex_t a = PTHREAD_MUTEX_INITIALIZER;
-pthread_mutex_t b = PTHREAD_MUTEX_INITIALIZER;
-pthread_barrier_t bar;
-
-void *ba_lock(void *arg)
-{
-	int ret, i;
-
-	pthread_mutex_lock(&b);
-
-	if (pthread_barrier_wait(&bar) == PTHREAD_BARRIER_SERIAL_THREAD)
-		pthread_barrier_destroy(&bar);
-
-	pthread_mutex_lock(&a);
-
-	pthread_mutex_unlock(&a);
-	pthread_mutex_unlock(&b);
-}
-
-int main(void)
-{
-	pthread_t t;
-
-	pthread_barrier_init(&bar, NULL, 2);
-
-	if (pthread_create(&t, NULL, ba_lock, NULL)) {
-		fprintf(stderr, "pthread_create() failed\n");
-		return 1;
-	}
-	pthread_mutex_lock(&a);
-
-	if (pthread_barrier_wait(&bar) == PTHREAD_BARRIER_SERIAL_THREAD)
-		pthread_barrier_destroy(&bar);
-
-	pthread_mutex_lock(&b);
-
-	pthread_mutex_unlock(&b);
-	pthread_mutex_unlock(&a);
-
-	pthread_join(t, NULL);
-
-	return 0;
-}
diff --git a/tools/lib/lockdep/tests/ABBA_2threads.sh b/tools/lib/lockdep/tests/ABBA_2threads.sh
deleted file mode 100644
index fc31c607a5a8b..0000000000000
--- a/tools/lib/lockdep/tests/ABBA_2threads.sh
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABBCCA.c b/tools/lib/lockdep/tests/ABBCCA.c
deleted file mode 100644
index 48446129d4966..0000000000000
--- a/tools/lib/lockdep/tests/ABBCCA.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <liblockdep/mutex.h>
-#include "common.h"
-
-void main(void)
-{
-	pthread_mutex_t a, b, c;
-
-	pthread_mutex_init(&a, NULL);
-	pthread_mutex_init(&b, NULL);
-	pthread_mutex_init(&c, NULL);
-
-	LOCK_UNLOCK_2(a, b);
-	LOCK_UNLOCK_2(b, c);
-	LOCK_UNLOCK_2(c, a);
-
-	pthread_mutex_destroy(&c);
-	pthread_mutex_destroy(&b);
-	pthread_mutex_destroy(&a);
-}
diff --git a/tools/lib/lockdep/tests/ABBCCA.sh b/tools/lib/lockdep/tests/ABBCCA.sh
deleted file mode 100644
index fc31c607a5a8b..0000000000000
--- a/tools/lib/lockdep/tests/ABBCCA.sh
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABBCCDDA.c b/tools/lib/lockdep/tests/ABBCCDDA.c
deleted file mode 100644
index 3570bf7b38042..0000000000000
--- a/tools/lib/lockdep/tests/ABBCCDDA.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <liblockdep/mutex.h>
-#include "common.h"
-
-void main(void)
-{
-	pthread_mutex_t a, b, c, d;
-
-	pthread_mutex_init(&a, NULL);
-	pthread_mutex_init(&b, NULL);
-	pthread_mutex_init(&c, NULL);
-	pthread_mutex_init(&d, NULL);
-
-	LOCK_UNLOCK_2(a, b);
-	LOCK_UNLOCK_2(b, c);
-	LOCK_UNLOCK_2(c, d);
-	LOCK_UNLOCK_2(d, a);
-
-	pthread_mutex_destroy(&d);
-	pthread_mutex_destroy(&c);
-	pthread_mutex_destroy(&b);
-	pthread_mutex_destroy(&a);
-}
diff --git a/tools/lib/lockdep/tests/ABBCCDDA.sh b/tools/lib/lockdep/tests/ABBCCDDA.sh
deleted file mode 100644
index fc31c607a5a8b..0000000000000
--- a/tools/lib/lockdep/tests/ABBCCDDA.sh
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABCABC.c b/tools/lib/lockdep/tests/ABCABC.c
deleted file mode 100644
index a1c4659894cd6..0000000000000
--- a/tools/lib/lockdep/tests/ABCABC.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <liblockdep/mutex.h>
-#include "common.h"
-
-void main(void)
-{
-	pthread_mutex_t a, b, c;
-
-	pthread_mutex_init(&a, NULL);
-	pthread_mutex_init(&b, NULL);
-	pthread_mutex_init(&c, NULL);
-
-	LOCK_UNLOCK_2(a, b);
-	LOCK_UNLOCK_2(c, a);
-	LOCK_UNLOCK_2(b, c);
-
-	pthread_mutex_destroy(&c);
-	pthread_mutex_destroy(&b);
-	pthread_mutex_destroy(&a);
-}
diff --git a/tools/lib/lockdep/tests/ABCABC.sh b/tools/lib/lockdep/tests/ABCABC.sh
deleted file mode 100644
index fc31c607a5a8b..0000000000000
--- a/tools/lib/lockdep/tests/ABCABC.sh
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABCDBCDA.c b/tools/lib/lockdep/tests/ABCDBCDA.c
deleted file mode 100644
index 335af1c90ab53..0000000000000
--- a/tools/lib/lockdep/tests/ABCDBCDA.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <liblockdep/mutex.h>
-#include "common.h"
-
-void main(void)
-{
-	pthread_mutex_t a, b, c, d;
-
-	pthread_mutex_init(&a, NULL);
-	pthread_mutex_init(&b, NULL);
-	pthread_mutex_init(&c, NULL);
-	pthread_mutex_init(&d, NULL);
-
-	LOCK_UNLOCK_2(a, b);
-	LOCK_UNLOCK_2(c, d);
-	LOCK_UNLOCK_2(b, c);
-	LOCK_UNLOCK_2(d, a);
-
-	pthread_mutex_destroy(&d);
-	pthread_mutex_destroy(&c);
-	pthread_mutex_destroy(&b);
-	pthread_mutex_destroy(&a);
-}
diff --git a/tools/lib/lockdep/tests/ABCDBCDA.sh b/tools/lib/lockdep/tests/ABCDBCDA.sh
deleted file mode 100644
index fc31c607a5a8b..0000000000000
--- a/tools/lib/lockdep/tests/ABCDBCDA.sh
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABCDBDDA.c b/tools/lib/lockdep/tests/ABCDBDDA.c
deleted file mode 100644
index 3c59728630493..0000000000000
--- a/tools/lib/lockdep/tests/ABCDBDDA.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <liblockdep/mutex.h>
-#include "common.h"
-
-void main(void)
-{
-	pthread_mutex_t a, b, c, d;
-
-	pthread_mutex_init(&a, NULL);
-	pthread_mutex_init(&b, NULL);
-	pthread_mutex_init(&c, NULL);
-	pthread_mutex_init(&d, NULL);
-
-	LOCK_UNLOCK_2(a, b);
-	LOCK_UNLOCK_2(c, d);
-	LOCK_UNLOCK_2(b, d);
-	LOCK_UNLOCK_2(d, a);
-
-	pthread_mutex_destroy(&d);
-	pthread_mutex_destroy(&c);
-	pthread_mutex_destroy(&b);
-	pthread_mutex_destroy(&a);
-}
diff --git a/tools/lib/lockdep/tests/ABCDBDDA.sh b/tools/lib/lockdep/tests/ABCDBDDA.sh
deleted file mode 100644
index fc31c607a5a8b..0000000000000
--- a/tools/lib/lockdep/tests/ABCDBDDA.sh
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/WW.c b/tools/lib/lockdep/tests/WW.c
deleted file mode 100644
index eee88df7fc41b..0000000000000
--- a/tools/lib/lockdep/tests/WW.c
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <liblockdep/rwlock.h>
-
-void main(void)
-{
-	pthread_rwlock_t a, b;
-
-	pthread_rwlock_init(&a, NULL);
-	pthread_rwlock_init(&b, NULL);
-
-	pthread_rwlock_wrlock(&a);
-	pthread_rwlock_rdlock(&b);
-	pthread_rwlock_wrlock(&a);
-}
diff --git a/tools/lib/lockdep/tests/WW.sh b/tools/lib/lockdep/tests/WW.sh
deleted file mode 100644
index f39b328650741..0000000000000
--- a/tools/lib/lockdep/tests/WW.sh
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-grep -q 'WARNING: possible recursive locking detected'
diff --git a/tools/lib/lockdep/tests/common.h b/tools/lib/lockdep/tests/common.h
deleted file mode 100644
index 3026c29ccb5c3..0000000000000
--- a/tools/lib/lockdep/tests/common.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LIBLOCKDEP_TEST_COMMON_H
-#define _LIBLOCKDEP_TEST_COMMON_H
-
-#define LOCK_UNLOCK_2(a, b)			\
-	do {					\
-		pthread_mutex_lock(&(a));	\
-		pthread_mutex_lock(&(b));	\
-		pthread_mutex_unlock(&(b));	\
-		pthread_mutex_unlock(&(a));	\
-	} while(0)
-
-#endif
diff --git a/tools/lib/lockdep/tests/unlock_balance.c b/tools/lib/lockdep/tests/unlock_balance.c
deleted file mode 100644
index dba25064b50a8..0000000000000
--- a/tools/lib/lockdep/tests/unlock_balance.c
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <liblockdep/mutex.h>
-
-void main(void)
-{
-	pthread_mutex_t a;
-
-	pthread_mutex_init(&a, NULL);
-
-	pthread_mutex_lock(&a);
-	pthread_mutex_unlock(&a);
-	pthread_mutex_unlock(&a);
-
-	pthread_mutex_destroy(&a);
-}
diff --git a/tools/lib/lockdep/tests/unlock_balance.sh b/tools/lib/lockdep/tests/unlock_balance.sh
deleted file mode 100644
index c6e3952303fe3..0000000000000
--- a/tools/lib/lockdep/tests/unlock_balance.sh
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-grep -q 'WARNING: bad unlock balance detected'
-- 
2.33.0

