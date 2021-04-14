Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974B435FB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353140AbhDNSsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353086AbhDNSrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:47:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E71661158;
        Wed, 14 Apr 2021 18:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618426012;
        bh=rmbrxWiJMKmv84JyYyju9JE/Sy3maJbLOduEb9kv6Io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5WJ8dKdr8wR+PltwaWOGx4k6wL0AhDfefbLHDsFD+/MeRPtxriYrQ/YKl5ztg3Ja
         1so5CXpMl/jPnTi/kYTeOg/zr056tRvVVZugfdal3cZ3BdwLd9tZ+ylkWpzlp/pFL5
         dVEaTZzSReoLgAchEm/8RTr2qT1eTcuuf9d0Lh98nUaEkLRwoPvotlNCECWbmlDx/g
         vpjj6JJNsP81LFhxH3Be/9IIk+O/RPKsHP9CEDWuTgtUc2w5DOto7565U2e9WrZvVN
         nT/fCIvaPohgXvNEvYbPKSWVeIT3TvfRFvzIUYXuSIGNBJBzuWKV910LCktv6Wsmb7
         LuvWrqRHL8s/Q==
From:   ojeda@kernel.org
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 07/13] Rust: Kernel crate
Date:   Wed, 14 Apr 2021 20:45:58 +0200
Message-Id: <20210414184604.23473-8-ojeda@kernel.org>
In-Reply-To: <20210414184604.23473-1-ojeda@kernel.org>
References: <20210414184604.23473-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Ojeda <ojeda@kernel.org>

The `kernel` crate currently includes all the abstractions that wrap
kernel features written in C.

These abstractions call the C side of the kernel via the generated
bindings with the `bindgen` tool. Modules developed in Rust should
never call the bindings themselves.

In the future, as the abstractions grow in number, we may need
to split this crate into several, possibly following a similar
subdivision in subsystems as the kernel itself.

For compiling the `kernel` crate, we also need `alloc` from Rust's
standard library. We also need a few new helpers.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Geoffrey Thomas <geofft@ldpreload.com>
Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
Co-developed-by: Finn Behrens <me@kloenk.de>
Signed-off-by: Finn Behrens <me@kloenk.de>
Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 include/linux/spinlock.h       |  17 +-
 kernel/printk/printk.c         |   2 +
 rust/Makefile                  |   4 +
 rust/helpers.c                 |  78 ++++
 rust/kernel/allocator.rs       |  68 ++++
 rust/kernel/bindings.rs        |  22 ++
 rust/kernel/bindings_helper.h  |  17 +
 rust/kernel/buffer.rs          |  39 ++
 rust/kernel/c_types.rs         | 133 +++++++
 rust/kernel/chrdev.rs          | 162 ++++++++
 rust/kernel/error.rs           | 106 ++++++
 rust/kernel/file_operations.rs | 668 +++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs             | 196 ++++++++++
 rust/kernel/miscdev.rs         | 109 ++++++
 rust/kernel/module_param.rs    | 497 ++++++++++++++++++++++++
 rust/kernel/prelude.rs         |  22 ++
 rust/kernel/print.rs           | 461 +++++++++++++++++++++++
 rust/kernel/random.rs          |  50 +++
 rust/kernel/static_assert.rs   |  38 ++
 rust/kernel/sync/arc.rs        | 184 +++++++++
 rust/kernel/sync/condvar.rs    | 138 +++++++
 rust/kernel/sync/guard.rs      |  82 ++++
 rust/kernel/sync/locked_by.rs  | 112 ++++++
 rust/kernel/sync/mod.rs        |  68 ++++
 rust/kernel/sync/mutex.rs      | 101 +++++
 rust/kernel/sync/spinlock.rs   | 108 ++++++
 rust/kernel/sysctl.rs          | 185 +++++++++
 rust/kernel/types.rs           |  73 ++++
 rust/kernel/user_ptr.rs        | 282 ++++++++++++++
 29 files changed, 4016 insertions(+), 6 deletions(-)
 create mode 100644 rust/kernel/allocator.rs
 create mode 100644 rust/kernel/bindings.rs
 create mode 100644 rust/kernel/bindings_helper.h
 create mode 100644 rust/kernel/buffer.rs
 create mode 100644 rust/kernel/c_types.rs
 create mode 100644 rust/kernel/chrdev.rs
 create mode 100644 rust/kernel/error.rs
 create mode 100644 rust/kernel/file_operations.rs
 create mode 100644 rust/kernel/lib.rs
 create mode 100644 rust/kernel/miscdev.rs
 create mode 100644 rust/kernel/module_param.rs
 create mode 100644 rust/kernel/prelude.rs
 create mode 100644 rust/kernel/print.rs
 create mode 100644 rust/kernel/random.rs
 create mode 100644 rust/kernel/static_assert.rs
 create mode 100644 rust/kernel/sync/arc.rs
 create mode 100644 rust/kernel/sync/condvar.rs
 create mode 100644 rust/kernel/sync/guard.rs
 create mode 100644 rust/kernel/sync/locked_by.rs
 create mode 100644 rust/kernel/sync/mod.rs
 create mode 100644 rust/kernel/sync/mutex.rs
 create mode 100644 rust/kernel/sync/spinlock.rs
 create mode 100644 rust/kernel/sysctl.rs
 create mode 100644 rust/kernel/types.rs
 create mode 100644 rust/kernel/user_ptr.rs

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 79897841a2cc..a022992725be 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -331,12 +331,17 @@ static __always_inline raw_spinlock_t *spinlock_check(spinlock_t *lock)
 
 #ifdef CONFIG_DEBUG_SPINLOCK
 
-# define spin_lock_init(lock)					\
-do {								\
-	static struct lock_class_key __key;			\
-								\
-	__raw_spin_lock_init(spinlock_check(lock),		\
-			     #lock, &__key, LD_WAIT_CONFIG);	\
+static inline void __spin_lock_init(spinlock_t *lock, const char *name,
+				    struct lock_class_key *key)
+{
+	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
+}
+
+# define spin_lock_init(lock)			\
+do {						\
+	static struct lock_class_key __key;	\
+						\
+	__spin_lock_init(lock, #lock, &__key);	\
 } while (0)
 
 #else
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 575a34b88936..d13be89530c4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -410,6 +410,8 @@ static u64 clear_seq;
 #else
 #define PREFIX_MAX		32
 #endif
+
+/* Keep in sync with rust/kernel/print.rs */
 #define LOG_LINE_MAX		(1024 - PREFIX_MAX)
 
 #define LOG_LEVEL(v)		((v) & 0x07)
diff --git a/rust/Makefile b/rust/Makefile
index 3fd827d4ac17..dbbbdbad6941 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -5,6 +5,10 @@ extra-$(CONFIG_RUST) += exports_core_generated.h
 
 extra-$(CONFIG_RUST) += libmodule.so
 
+extra-$(CONFIG_RUST) += bindings_generated.rs
+obj-$(CONFIG_RUST) += alloc.o kernel.o
+extra-$(CONFIG_RUST) += exports_alloc_generated.h exports_kernel_generated.h
+
 RUSTDOC = rustdoc
 
 quiet_cmd_rustdoc = RUSTDOC $<
diff --git a/rust/helpers.c b/rust/helpers.c
index 5c2346dd379b..4cae8c27f8f9 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -1,8 +1,86 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/bug.h>
+#include <linux/build_bug.h>
+#include <linux/uaccess.h>
+#include <linux/sched/signal.h>
+#include <linux/gfp.h>
+#include <linux/highmem.h>
 
 void rust_helper_BUG(void)
 {
 	BUG();
 }
+
+unsigned long rust_helper_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	return copy_from_user(to, from, n);
+}
+
+unsigned long rust_helper_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	return copy_to_user(to, from, n);
+}
+
+void rust_helper_spin_lock_init(spinlock_t *lock, const char *name,
+				struct lock_class_key *key)
+{
+#ifdef CONFIG_DEBUG_SPINLOCK
+	__spin_lock_init(lock, name, key);
+#else
+	spin_lock_init(lock);
+#endif
+}
+EXPORT_SYMBOL_GPL(rust_helper_spin_lock_init);
+
+void rust_helper_spin_lock(spinlock_t *lock)
+{
+	spin_lock(lock);
+}
+EXPORT_SYMBOL_GPL(rust_helper_spin_lock);
+
+void rust_helper_spin_unlock(spinlock_t *lock)
+{
+	spin_unlock(lock);
+}
+EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
+
+void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
+{
+	init_wait(wq_entry);
+}
+EXPORT_SYMBOL_GPL(rust_helper_init_wait);
+
+int rust_helper_current_pid(void)
+{
+	return current->pid;
+}
+EXPORT_SYMBOL_GPL(rust_helper_current_pid);
+
+int rust_helper_signal_pending(void)
+{
+	return signal_pending(current);
+}
+EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
+
+struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
+{
+	return alloc_pages(gfp_mask, order);
+}
+EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
+
+void *rust_helper_kmap(struct page *page)
+{
+	return kmap(page);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kmap);
+
+void rust_helper_kunmap(struct page *page)
+{
+	return kunmap(page);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kunmap);
+
+// See https://github.com/rust-lang/rust-bindgen/issues/1671
+static_assert(__builtin_types_compatible_p(size_t, uintptr_t),
+	"size_t must match uintptr_t, what architecture is this??");
diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
new file mode 100644
index 000000000000..81104f2d8ffa
--- /dev/null
+++ b/rust/kernel/allocator.rs
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Allocator support.
+
+use core::alloc::{GlobalAlloc, Layout};
+use core::ptr;
+
+use crate::bindings;
+use crate::c_types;
+
+pub struct KernelAllocator;
+
+unsafe impl GlobalAlloc for KernelAllocator {
+    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
+        // `krealloc()` is used instead of `kmalloc()` because the latter is
+        // an inline function and cannot be bound to as a result.
+        bindings::krealloc(ptr::null(), layout.size(), bindings::GFP_KERNEL) as *mut u8
+    }
+
+    unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
+        bindings::kfree(ptr as *const c_types::c_void);
+    }
+}
+
+#[alloc_error_handler]
+fn oom(_layout: Layout) -> ! {
+    panic!("Out of memory!");
+}
+
+// `rustc` only generates these for some crate types. Even then, we would need
+// to extract the object file that has them from the archive. For the moment,
+// let's generate them ourselves instead.
+#[no_mangle]
+pub fn __rust_alloc(size: usize, _align: usize) -> *mut u8 {
+    unsafe { bindings::krealloc(core::ptr::null(), size, bindings::GFP_KERNEL) as *mut u8 }
+}
+
+#[no_mangle]
+pub fn __rust_dealloc(ptr: *mut u8, _size: usize, _align: usize) {
+    unsafe { bindings::kfree(ptr as *const c_types::c_void) };
+}
+
+#[no_mangle]
+pub fn __rust_realloc(ptr: *mut u8, _old_size: usize, _align: usize, new_size: usize) -> *mut u8 {
+    unsafe {
+        bindings::krealloc(
+            ptr as *const c_types::c_void,
+            new_size,
+            bindings::GFP_KERNEL,
+        ) as *mut u8
+    }
+}
+
+#[no_mangle]
+pub fn __rust_alloc_zeroed(size: usize, _align: usize) -> *mut u8 {
+    unsafe {
+        bindings::krealloc(
+            core::ptr::null(),
+            size,
+            bindings::GFP_KERNEL | bindings::__GFP_ZERO,
+        ) as *mut u8
+    }
+}
+
+#[no_mangle]
+pub fn __rust_alloc_error_handler(_size: usize, _align: usize) -> ! {
+    panic!("Out of memory!");
+}
diff --git a/rust/kernel/bindings.rs b/rust/kernel/bindings.rs
new file mode 100644
index 000000000000..6a300f52335c
--- /dev/null
+++ b/rust/kernel/bindings.rs
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bindings
+//!
+//! Imports the generated bindings by `bindgen`.
+
+#[allow(
+    clippy::all,
+    non_camel_case_types,
+    non_upper_case_globals,
+    non_snake_case,
+    improper_ctypes
+)]
+mod bindings_raw {
+    use crate::c_types;
+    include!(env!("RUST_BINDINGS_FILE"));
+}
+pub use bindings_raw::*;
+
+pub const GFP_KERNEL: gfp_t = BINDINGS_GFP_KERNEL;
+pub const __GFP_ZERO: gfp_t = BINDINGS___GFP_ZERO;
+pub const __GFP_HIGHMEM: gfp_t = ___GFP_HIGHMEM;
diff --git a/rust/kernel/bindings_helper.h b/rust/kernel/bindings_helper.h
new file mode 100644
index 000000000000..75b68235f6c7
--- /dev/null
+++ b/rust/kernel/bindings_helper.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/sysctl.h>
+#include <linux/uaccess.h>
+#include <linux/version.h>
+#include <linux/miscdevice.h>
+#include <linux/poll.h>
+#include <linux/mm.h>
+
+// `bindgen` gets confused at certain things
+const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
+const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
diff --git a/rust/kernel/buffer.rs b/rust/kernel/buffer.rs
new file mode 100644
index 000000000000..b2502fa968fe
--- /dev/null
+++ b/rust/kernel/buffer.rs
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Struct for writing to a pre-allocated buffer with the [`write!`] macro.
+
+use core::fmt;
+
+/// A pre-allocated buffer that implements [`core::fmt::Write`].
+///
+/// Consecutive writes will append to what has already been written.
+/// Writes that don't fit in the buffer will fail.
+pub struct Buffer<'a> {
+    slice: &'a mut [u8],
+    pos: usize,
+}
+
+impl<'a> Buffer<'a> {
+    /// Create a new buffer from an existing array.
+    pub fn new(slice: &'a mut [u8]) -> Self {
+        Buffer { slice, pos: 0 }
+    }
+
+    /// Number of bytes that have already been written to the buffer.
+    /// This will always be less than the length of the original array.
+    pub fn bytes_written(&self) -> usize {
+        self.pos
+    }
+}
+
+impl<'a> fmt::Write for Buffer<'a> {
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        if s.len() > self.slice.len() - self.pos {
+            Err(fmt::Error)
+        } else {
+            self.slice[self.pos..self.pos + s.len()].copy_from_slice(s.as_bytes());
+            self.pos += s.len();
+            Ok(())
+        }
+    }
+}
diff --git a/rust/kernel/c_types.rs b/rust/kernel/c_types.rs
new file mode 100644
index 000000000000..10486b41efa9
--- /dev/null
+++ b/rust/kernel/c_types.rs
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! C types for the bindings.
+//!
+//! The bindings generated by `bindgen` use these types to map to the C ones.
+//!
+//! C's standard integer types may differ in width depending on
+//! the architecture, thus we need to conditionally compile those.
+
+#![allow(non_camel_case_types)]
+
+#[cfg(any(target_arch = "arm", target_arch = "x86"))]
+mod c {
+    /// C `void` type.
+    pub type c_void = core::ffi::c_void;
+
+    /// C `char` type.
+    pub type c_char = i8;
+
+    /// C `signed char` type.
+    pub type c_schar = i8;
+
+    /// C `unsigned char` type.
+    pub type c_uchar = u8;
+
+    /// C `short` type.
+    pub type c_short = i16;
+
+    /// C `unsigned short` type.
+    pub type c_ushort = u16;
+
+    /// C `int` type.
+    pub type c_int = i32;
+
+    /// C `unsigned int` type.
+    pub type c_uint = u32;
+
+    /// C `long` type.
+    pub type c_long = i32;
+
+    /// C `unsigned long` type.
+    pub type c_ulong = u32;
+
+    /// C `long long` type.
+    pub type c_longlong = i64;
+
+    /// C `unsigned long long` type.
+    pub type c_ulonglong = u64;
+
+    /// C `ssize_t` type (typically defined in `<sys/types.h>` by POSIX).
+    ///
+    /// For some 32-bit architectures like this one, the kernel defines it as
+    /// `int`, i.e. it is an [`i32`].
+    pub type c_ssize_t = isize;
+
+    /// C `size_t` type (typically defined in `<stddef.h>`).
+    ///
+    /// For some 32-bit architectures like this one, the kernel defines it as
+    /// `unsigned int`, i.e. it is an [`u32`].
+    pub type c_size_t = usize;
+}
+
+#[cfg(any(
+    target_arch = "aarch64",
+    target_arch = "x86_64",
+    target_arch = "powerpc64"
+))]
+mod c {
+    /// C `void` type.
+    pub type c_void = core::ffi::c_void;
+
+    /// C `char` type.
+    pub type c_char = i8;
+
+    /// C `signed char` type.
+    pub type c_schar = i8;
+
+    /// C `unsigned char` type.
+    pub type c_uchar = u8;
+
+    /// C `short` type.
+    pub type c_short = i16;
+
+    /// C `unsigned short` type.
+    pub type c_ushort = u16;
+
+    /// C `int` type.
+    pub type c_int = i32;
+
+    /// C `unsigned int` type.
+    pub type c_uint = u32;
+
+    /// C `long` type.
+    pub type c_long = i64;
+
+    /// C `unsigned long` type.
+    pub type c_ulong = u64;
+
+    /// C `long long` type.
+    pub type c_longlong = i64;
+
+    /// C `unsigned long long` type.
+    pub type c_ulonglong = u64;
+
+    /// C `ssize_t` type (typically defined in `<sys/types.h>` by POSIX).
+    ///
+    /// For 64-bit architectures like this one, the kernel defines it as
+    /// `long`, i.e. it is an [`i64`].
+    pub type c_ssize_t = isize;
+
+    /// C `size_t` type (typically defined in `<stddef.h>`).
+    ///
+    /// For 64-bit architectures like this one, the kernel defines it as
+    /// `unsigned long`, i.e. it is an [`u64`].
+    pub type c_size_t = usize;
+}
+
+pub use c::*;
+
+/// Reads string until null byte is reached and returns slice excluding the
+/// terminating null.
+///
+/// # Safety
+///
+/// The data from the pointer until the null terminator must be valid for reads
+/// and not mutated for all of `'a`. The length of the string must also be less
+/// than `isize::MAX`. See the documentation on
+/// [`core::slice::from_raw_parts()`] for further details on safety of
+/// converting a pointer to a slice.
+pub unsafe fn c_string_bytes<'a>(ptr: *const crate::c_types::c_char) -> &'a [u8] {
+    let length = crate::bindings::strlen(ptr) as usize;
+    &core::slice::from_raw_parts(ptr as *const u8, length)
+}
diff --git a/rust/kernel/chrdev.rs b/rust/kernel/chrdev.rs
new file mode 100644
index 000000000000..6772a3a925cc
--- /dev/null
+++ b/rust/kernel/chrdev.rs
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Character devices.
+//!
+//! Also called "char devices", `chrdev`, `cdev`.
+//!
+//! C header: [`include/linux/cdev.h`](../../../../include/linux/cdev.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#char-devices>
+
+use alloc::boxed::Box;
+use core::convert::TryInto;
+use core::marker::PhantomPinned;
+use core::mem::MaybeUninit;
+use core::pin::Pin;
+
+use crate::bindings;
+use crate::c_types;
+use crate::error::{Error, KernelResult};
+use crate::file_operations;
+use crate::types::CStr;
+
+struct RegistrationInner<const N: usize> {
+    dev: bindings::dev_t,
+    used: usize,
+    cdevs: [MaybeUninit<bindings::cdev>; N],
+    _pin: PhantomPinned,
+}
+
+/// Character device registration.
+///
+/// May contain up to a fixed number (`N`) of devices. Must be pinned.
+pub struct Registration<const N: usize> {
+    name: CStr<'static>,
+    minors_start: u16,
+    this_module: &'static crate::ThisModule,
+    inner: Option<RegistrationInner<N>>,
+}
+
+impl<const N: usize> Registration<{ N }> {
+    /// Creates a [`Registration`] object for a character device.
+    ///
+    /// This does *not* register the device: see [`Self::register()`].
+    ///
+    /// This associated function is intended to be used when you need to avoid
+    /// a memory allocation, e.g. when the [`Registration`] is a member of
+    /// a bigger structure inside your [`crate::KernelModule`] instance. If you
+    /// are going to pin the registration right away, call
+    /// [`Self::new_pinned()`] instead.
+    pub fn new(
+        name: CStr<'static>,
+        minors_start: u16,
+        this_module: &'static crate::ThisModule,
+    ) -> Self {
+        Registration {
+            name,
+            minors_start,
+            this_module,
+            inner: None,
+        }
+    }
+
+    /// Creates a pinned [`Registration`] object for a character device.
+    ///
+    /// This does *not* register the device: see [`Self::register()`].
+    pub fn new_pinned(
+        name: CStr<'static>,
+        minors_start: u16,
+        this_module: &'static crate::ThisModule,
+    ) -> KernelResult<Pin<Box<Self>>> {
+        Ok(Pin::from(Box::try_new(Self::new(
+            name,
+            minors_start,
+            this_module,
+        ))?))
+    }
+
+    /// Registers a character device.
+    ///
+    /// You may call this once per device type, up to `N` times.
+    pub fn register<T: file_operations::FileOpener<()>>(self: Pin<&mut Self>) -> KernelResult {
+        // SAFETY: We must ensure that we never move out of `this`.
+        let this = unsafe { self.get_unchecked_mut() };
+        if this.inner.is_none() {
+            let mut dev: bindings::dev_t = 0;
+            // SAFETY: Calling unsafe function. `this.name` has `'static`
+            // lifetime.
+            let res = unsafe {
+                bindings::alloc_chrdev_region(
+                    &mut dev,
+                    this.minors_start.into(),
+                    N.try_into()?,
+                    this.name.as_ptr() as *const c_types::c_char,
+                )
+            };
+            if res != 0 {
+                return Err(Error::from_kernel_errno(res));
+            }
+            this.inner = Some(RegistrationInner {
+                dev,
+                used: 0,
+                cdevs: [MaybeUninit::<bindings::cdev>::uninit(); N],
+                _pin: PhantomPinned,
+            });
+        }
+
+        let mut inner = this.inner.as_mut().unwrap();
+        if inner.used == N {
+            return Err(Error::EINVAL);
+        }
+        let cdev = inner.cdevs[inner.used].as_mut_ptr();
+        // SAFETY: Calling unsafe functions and manipulating `MaybeUninit`
+        // pointer.
+        unsafe {
+            bindings::cdev_init(
+                cdev,
+                // SAFETY: The adapter doesn't retrieve any state yet, so it's compatible with any
+                // registration.
+                file_operations::FileOperationsVtable::<Self, T>::build(),
+            );
+            (*cdev).owner = this.this_module.0;
+            let rc = bindings::cdev_add(cdev, inner.dev + inner.used as bindings::dev_t, 1);
+            if rc != 0 {
+                return Err(Error::from_kernel_errno(rc));
+            }
+        }
+        inner.used += 1;
+        Ok(())
+    }
+}
+
+impl<const N: usize> file_operations::FileOpenAdapter for Registration<{ N }> {
+    type Arg = ();
+
+    unsafe fn convert(
+        _inode: *mut bindings::inode,
+        _file: *mut bindings::file,
+    ) -> *const Self::Arg {
+        // TODO: Update the SAFETY comment on the call to `FileOperationsVTable::build` above once
+        // this is updated to retrieve state.
+        &()
+    }
+}
+
+// SAFETY: `Registration` does not expose any of its state across threads
+// (it is fine for multiple threads to have a shared reference to it).
+unsafe impl<const N: usize> Sync for Registration<{ N }> {}
+
+impl<const N: usize> Drop for Registration<{ N }> {
+    fn drop(&mut self) {
+        if let Some(inner) = self.inner.as_mut() {
+            // SAFETY: Calling unsafe functions, `0..inner.used` of
+            // `inner.cdevs` are initialized in `Registration::register`.
+            unsafe {
+                for i in 0..inner.used {
+                    bindings::cdev_del(inner.cdevs[i].as_mut_ptr());
+                }
+                bindings::unregister_chrdev_region(inner.dev, N.try_into().unwrap());
+            }
+        }
+    }
+}
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
new file mode 100644
index 000000000000..432d866232c1
--- /dev/null
+++ b/rust/kernel/error.rs
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel errors.
+//!
+//! C header: [`include/uapi/asm-generic/errno-base.h`](../../../include/uapi/asm-generic/errno-base.h)
+
+use crate::{bindings, c_types};
+use alloc::{alloc::AllocError, collections::TryReserveError};
+use core::{num::TryFromIntError, str::Utf8Error};
+
+/// Generic integer kernel error.
+///
+/// The kernel defines a set of integer generic error codes based on C and
+/// POSIX ones. These codes may have a more specific meaning in some contexts.
+pub struct Error(c_types::c_int);
+
+impl Error {
+    /// Invalid argument.
+    pub const EINVAL: Self = Error(-(bindings::EINVAL as i32));
+
+    /// Out of memory.
+    pub const ENOMEM: Self = Error(-(bindings::ENOMEM as i32));
+
+    /// Bad address.
+    pub const EFAULT: Self = Error(-(bindings::EFAULT as i32));
+
+    /// Illegal seek.
+    pub const ESPIPE: Self = Error(-(bindings::ESPIPE as i32));
+
+    /// Try again.
+    pub const EAGAIN: Self = Error(-(bindings::EAGAIN as i32));
+
+    /// Device or resource busy.
+    pub const EBUSY: Self = Error(-(bindings::EBUSY as i32));
+
+    /// Restart the system call.
+    pub const ERESTARTSYS: Self = Error(-(bindings::ERESTARTSYS as i32));
+
+    /// Operation not permitted.
+    pub const EPERM: Self = Error(-(bindings::EPERM as i32));
+
+    /// No such process.
+    pub const ESRCH: Self = Error(-(bindings::ESRCH as i32));
+
+    /// No such file or directory.
+    pub const ENOENT: Self = Error(-(bindings::ENOENT as i32));
+
+    /// Interrupted system call.
+    pub const EINTR: Self = Error(-(bindings::EINTR as i32));
+
+    /// Creates an [`Error`] from a kernel error code.
+    pub fn from_kernel_errno(errno: c_types::c_int) -> Error {
+        Error(errno)
+    }
+
+    /// Returns the kernel error code.
+    pub fn to_kernel_errno(&self) -> c_types::c_int {
+        self.0
+    }
+}
+
+impl From<TryFromIntError> for Error {
+    fn from(_: TryFromIntError) -> Error {
+        Error::EINVAL
+    }
+}
+
+impl From<Utf8Error> for Error {
+    fn from(_: Utf8Error) -> Error {
+        Error::EINVAL
+    }
+}
+
+impl From<TryReserveError> for Error {
+    fn from(_: TryReserveError) -> Error {
+        Error::ENOMEM
+    }
+}
+
+/// A [`Result`] with an [`Error`] error type.
+///
+/// To be used as the return type for functions that may fail.
+///
+/// # Error codes in C and Rust
+///
+/// In C, it is common that functions indicate success or failure through
+/// their return value; modifying or returning extra data through non-`const`
+/// pointer parameters. In particular, in the kernel, functions that may fail
+/// typically return an `int` that represents a generic error code. We model
+/// those as [`Error`].
+///
+/// In Rust, it is idiomatic to model functions that may fail as returning
+/// a [`Result`]. Since in the kernel many functions return an error code,
+/// [`KernelResult`] is a type alias for a [`Result`] that uses [`Error`] as
+/// its error type.
+///
+/// Note that even if a function does not return anything when it succeeds,
+/// it should still be modeled as returning a `KernelResult` rather than
+/// just an [`Error`].
+pub type KernelResult<T = ()> = Result<T, Error>;
+
+impl From<AllocError> for Error {
+    fn from(_: AllocError) -> Error {
+        Error::ENOMEM
+    }
+}
diff --git a/rust/kernel/file_operations.rs b/rust/kernel/file_operations.rs
new file mode 100644
index 000000000000..f54ddd0b1da0
--- /dev/null
+++ b/rust/kernel/file_operations.rs
@@ -0,0 +1,668 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! File operations.
+//!
+//! C header: [`include/linux/fs.h`](../../../../include/linux/fs.h)
+
+use core::convert::{TryFrom, TryInto};
+use core::{marker, mem, ops::Deref, pin::Pin, ptr};
+
+use alloc::boxed::Box;
+use alloc::sync::Arc;
+
+use crate::bindings;
+use crate::c_types;
+use crate::error::{Error, KernelResult};
+use crate::sync::{CondVar, Ref, RefCounted};
+use crate::user_ptr::{UserSlicePtr, UserSlicePtrReader, UserSlicePtrWriter};
+
+/// Wraps the kernel's `struct file`.
+///
+/// # Invariants
+///
+/// The pointer [`File::ptr`] is non-null and valid.
+pub struct File {
+    ptr: *const bindings::file,
+}
+
+impl File {
+    /// Constructs a new [`struct file`] wrapper.
+    ///
+    /// # Safety
+    ///
+    /// The pointer `ptr` must be non-null and valid for the lifetime of the object.
+    unsafe fn from_ptr(ptr: *const bindings::file) -> File {
+        // INVARIANTS: the safety contract ensures the type invariant will hold.
+        File { ptr }
+    }
+
+    /// Returns the current seek/cursor/pointer position (`struct file::f_pos`).
+    pub fn pos(&self) -> u64 {
+        // SAFETY: `File::ptr` is guaranteed to be valid by the type invariants.
+        unsafe { (*self.ptr).f_pos as u64 }
+    }
+
+    /// Returns whether the file is in blocking mode.
+    pub fn is_blocking(&self) -> bool {
+        // SAFETY: `File::ptr` is guaranteed to be valid by the type invariants.
+        unsafe { (*self.ptr).f_flags & bindings::O_NONBLOCK == 0 }
+    }
+}
+
+/// Wraps the kernel's `struct poll_table_struct`.
+///
+/// # Invariants
+///
+/// The pointer [`PollTable::ptr`] is null or valid.
+pub struct PollTable {
+    ptr: *mut bindings::poll_table_struct,
+}
+
+impl PollTable {
+    /// Constructors a new `struct poll_table_struct` wrapper.
+    ///
+    /// # Safety
+    ///
+    /// The pointer `ptr` must be either null or a valid pointer for the lifetime of the object.
+    unsafe fn from_ptr(ptr: *mut bindings::poll_table_struct) -> Self {
+        Self { ptr }
+    }
+
+    /// Associates the given file and condition variable to this poll table. It means notifying the
+    /// condition variable will notify the poll table as well; additionally, the association
+    /// between the condition variable and the file will automatically be undone by the kernel when
+    /// the file is destructed. To unilaterally remove the association before then, one can call
+    /// [`CondVar::free_waiters`].
+    ///
+    /// # Safety
+    ///
+    /// If the condition variable is destroyed before the file, then [`CondVar::free_waiters`] must
+    /// be called to ensure that all waiters are flushed out.
+    pub unsafe fn register_wait<'a>(&self, file: &'a File, cv: &'a CondVar) {
+        if self.ptr.is_null() {
+            return;
+        }
+
+        // SAFETY: `PollTable::ptr` is guaranteed to be valid by the type invariants and the null
+        // check above.
+        let table = &*self.ptr;
+        if let Some(proc) = table._qproc {
+            // SAFETY: All pointers are known to be valid.
+            proc(file.ptr as _, cv.wait_list.get(), self.ptr)
+        }
+    }
+}
+
+/// Equivalent to [`std::io::SeekFrom`].
+///
+/// [`std::io::SeekFrom`]: https://doc.rust-lang.org/std/io/enum.SeekFrom.html
+pub enum SeekFrom {
+    /// Equivalent to C's `SEEK_SET`.
+    Start(u64),
+
+    /// Equivalent to C's `SEEK_END`.
+    End(i64),
+
+    /// Equivalent to C's `SEEK_CUR`.
+    Current(i64),
+}
+
+fn from_kernel_result<T>(r: KernelResult<T>) -> T
+where
+    T: TryFrom<c_types::c_int>,
+    T::Error: core::fmt::Debug,
+{
+    match r {
+        Ok(v) => v,
+        Err(e) => T::try_from(e.to_kernel_errno()).unwrap(),
+    }
+}
+
+macro_rules! from_kernel_result {
+    ($($tt:tt)*) => {{
+        from_kernel_result((|| {
+            $($tt)*
+        })())
+    }};
+}
+
+unsafe extern "C" fn open_callback<A: FileOpenAdapter, T: FileOpener<A::Arg>>(
+    inode: *mut bindings::inode,
+    file: *mut bindings::file,
+) -> c_types::c_int {
+    from_kernel_result! {
+        let arg = A::convert(inode, file);
+        let ptr = T::open(&*arg)?.into_pointer();
+        (*file).private_data = ptr as *mut c_types::c_void;
+        Ok(0)
+    }
+}
+
+unsafe extern "C" fn read_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    buf: *mut c_types::c_char,
+    len: c_types::c_size_t,
+    offset: *mut bindings::loff_t,
+) -> c_types::c_ssize_t {
+    from_kernel_result! {
+        let mut data = UserSlicePtr::new(buf as *mut c_types::c_void, len).writer();
+        let f = &*((*file).private_data as *const T);
+        // No `FMODE_UNSIGNED_OFFSET` support, so `offset` must be in [0, 2^63).
+        // See discussion in https://github.com/fishinabarrel/linux-kernel-module-rust/pull/113
+        let read = f.read(&File::from_ptr(file), &mut data, (*offset).try_into()?)?;
+        (*offset) += bindings::loff_t::try_from(read).unwrap();
+        Ok(read as _)
+    }
+}
+
+unsafe extern "C" fn write_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    buf: *const c_types::c_char,
+    len: c_types::c_size_t,
+    offset: *mut bindings::loff_t,
+) -> c_types::c_ssize_t {
+    from_kernel_result! {
+        let mut data = UserSlicePtr::new(buf as *mut c_types::c_void, len).reader();
+        let f = &*((*file).private_data as *const T);
+        // No `FMODE_UNSIGNED_OFFSET` support, so `offset` must be in [0, 2^63).
+        // See discussion in https://github.com/fishinabarrel/linux-kernel-module-rust/pull/113
+        let written = f.write(&mut data, (*offset).try_into()?)?;
+        (*offset) += bindings::loff_t::try_from(written).unwrap();
+        Ok(written as _)
+    }
+}
+
+unsafe extern "C" fn release_callback<T: FileOperations>(
+    _inode: *mut bindings::inode,
+    file: *mut bindings::file,
+) -> c_types::c_int {
+    let ptr = mem::replace(&mut (*file).private_data, ptr::null_mut());
+    T::release(T::Wrapper::from_pointer(ptr as _), &File::from_ptr(file));
+    0
+}
+
+unsafe extern "C" fn llseek_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    offset: bindings::loff_t,
+    whence: c_types::c_int,
+) -> bindings::loff_t {
+    from_kernel_result! {
+        let off = match whence as u32 {
+            bindings::SEEK_SET => SeekFrom::Start(offset.try_into()?),
+            bindings::SEEK_CUR => SeekFrom::Current(offset),
+            bindings::SEEK_END => SeekFrom::End(offset),
+            _ => return Err(Error::EINVAL),
+        };
+        let f = &*((*file).private_data as *const T);
+        let off = f.seek(&File::from_ptr(file), off)?;
+        Ok(off as bindings::loff_t)
+    }
+}
+
+unsafe extern "C" fn unlocked_ioctl_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    cmd: c_types::c_uint,
+    arg: c_types::c_ulong,
+) -> c_types::c_long {
+    from_kernel_result! {
+        let f = &*((*file).private_data as *const T);
+        // SAFETY: This function is called by the kernel, so it must set `fs` appropriately.
+        let mut cmd = IoctlCommand::new(cmd as _, arg as _);
+        let ret = f.ioctl(&File::from_ptr(file), &mut cmd)?;
+        Ok(ret as _)
+    }
+}
+
+unsafe extern "C" fn compat_ioctl_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    cmd: c_types::c_uint,
+    arg: c_types::c_ulong,
+) -> c_types::c_long {
+    from_kernel_result! {
+        let f = &*((*file).private_data as *const T);
+        // SAFETY: This function is called by the kernel, so it must set `fs` appropriately.
+        let mut cmd = IoctlCommand::new(cmd as _, arg as _);
+        let ret = f.compat_ioctl(&File::from_ptr(file), &mut cmd)?;
+        Ok(ret as _)
+    }
+}
+
+unsafe extern "C" fn mmap_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    vma: *mut bindings::vm_area_struct,
+) -> c_types::c_int {
+    from_kernel_result! {
+        let f = &*((*file).private_data as *const T);
+        f.mmap(&File::from_ptr(file), &mut *vma)?;
+        Ok(0)
+    }
+}
+
+unsafe extern "C" fn fsync_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    start: bindings::loff_t,
+    end: bindings::loff_t,
+    datasync: c_types::c_int,
+) -> c_types::c_int {
+    from_kernel_result! {
+        let start = start.try_into()?;
+        let end = end.try_into()?;
+        let datasync = datasync != 0;
+        let f = &*((*file).private_data as *const T);
+        let res = f.fsync(&File::from_ptr(file), start, end, datasync)?;
+        Ok(res.try_into().unwrap())
+    }
+}
+
+unsafe extern "C" fn poll_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    wait: *mut bindings::poll_table_struct,
+) -> bindings::__poll_t {
+    let f = &*((*file).private_data as *const T);
+    match f.poll(&File::from_ptr(file), &PollTable::from_ptr(wait)) {
+        Ok(v) => v,
+        Err(_) => bindings::POLLERR,
+    }
+}
+
+pub(crate) struct FileOperationsVtable<A, T>(marker::PhantomData<A>, marker::PhantomData<T>);
+
+impl<A: FileOpenAdapter, T: FileOpener<A::Arg>> FileOperationsVtable<A, T> {
+    const VTABLE: bindings::file_operations = bindings::file_operations {
+        open: Some(open_callback::<A, T>),
+        release: Some(release_callback::<T>),
+        read: if T::TO_USE.read {
+            Some(read_callback::<T>)
+        } else {
+            None
+        },
+        write: if T::TO_USE.write {
+            Some(write_callback::<T>)
+        } else {
+            None
+        },
+        llseek: if T::TO_USE.seek {
+            Some(llseek_callback::<T>)
+        } else {
+            None
+        },
+
+        check_flags: None,
+        compat_ioctl: if T::TO_USE.compat_ioctl {
+            Some(compat_ioctl_callback::<T>)
+        } else {
+            None
+        },
+        copy_file_range: None,
+        fallocate: None,
+        fadvise: None,
+        fasync: None,
+        flock: None,
+        flush: None,
+        fsync: if T::TO_USE.fsync {
+            Some(fsync_callback::<T>)
+        } else {
+            None
+        },
+        get_unmapped_area: None,
+        iterate: None,
+        iterate_shared: None,
+        iopoll: None,
+        lock: None,
+        mmap: if T::TO_USE.mmap {
+            Some(mmap_callback::<T>)
+        } else {
+            None
+        },
+        mmap_supported_flags: 0,
+        owner: ptr::null_mut(),
+        poll: if T::TO_USE.poll {
+            Some(poll_callback::<T>)
+        } else {
+            None
+        },
+        read_iter: None,
+        remap_file_range: None,
+        sendpage: None,
+        setlease: None,
+        show_fdinfo: None,
+        splice_read: None,
+        splice_write: None,
+        unlocked_ioctl: if T::TO_USE.ioctl {
+            Some(unlocked_ioctl_callback::<T>)
+        } else {
+            None
+        },
+        write_iter: None,
+    };
+
+    /// Builds an instance of [`struct file_operations`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the adapter is compatible with the way the device is registered.
+    pub(crate) const unsafe fn build() -> &'static bindings::file_operations {
+        &Self::VTABLE
+    }
+}
+
+/// Represents which fields of [`struct file_operations`] should be populated with pointers.
+pub struct ToUse {
+    /// The `read` field of [`struct file_operations`].
+    pub read: bool,
+
+    /// The `write` field of [`struct file_operations`].
+    pub write: bool,
+
+    /// The `llseek` field of [`struct file_operations`].
+    pub seek: bool,
+
+    /// The `unlocked_ioctl` field of [`struct file_operations`].
+    pub ioctl: bool,
+
+    /// The `compat_ioctl` field of [`struct file_operations`].
+    pub compat_ioctl: bool,
+
+    /// The `fsync` field of [`struct file_operations`].
+    pub fsync: bool,
+
+    /// The `mmap` field of [`struct file_operations`].
+    pub mmap: bool,
+
+    /// The `poll` field of [`struct file_operations`].
+    pub poll: bool,
+}
+
+/// A constant version where all values are to set to `false`, that is, all supported fields will
+/// be set to null pointers.
+pub const USE_NONE: ToUse = ToUse {
+    read: false,
+    write: false,
+    seek: false,
+    ioctl: false,
+    compat_ioctl: false,
+    fsync: false,
+    mmap: false,
+    poll: false,
+};
+
+/// Defines the [`FileOperations::TO_USE`] field based on a list of fields to be populated.
+#[macro_export]
+macro_rules! declare_file_operations {
+    () => {
+        const TO_USE: $crate::file_operations::ToUse = $crate::file_operations::USE_NONE;
+    };
+    ($($i:ident),+) => {
+        const TO_USE: kernel::file_operations::ToUse =
+            $crate::file_operations::ToUse {
+                $($i: true),+ ,
+                ..$crate::file_operations::USE_NONE
+            };
+    };
+}
+
+/// Allows the handling of ioctls defined with the `_IO`, `_IOR`, `_IOW`, and `_IOWR` macros.
+///
+/// For each macro, there is a handler function that takes the appropriate types as arguments.
+pub trait IoctlHandler: Sync {
+    /// Handles ioctls defined with the `_IO` macro, that is, with no buffer as argument.
+    fn pure(&self, _file: &File, _cmd: u32, _arg: usize) -> KernelResult<i32> {
+        Err(Error::EINVAL)
+    }
+
+    /// Handles ioctls defined with the `_IOR` macro, that is, with an output buffer provided as
+    /// argument.
+    fn read(&self, _file: &File, _cmd: u32, _writer: &mut UserSlicePtrWriter) -> KernelResult<i32> {
+        Err(Error::EINVAL)
+    }
+
+    /// Handles ioctls defined with the `_IOW` macro, that is, with an input buffer provided as
+    /// argument.
+    fn write(
+        &self,
+        _file: &File,
+        _cmd: u32,
+        _reader: &mut UserSlicePtrReader,
+    ) -> KernelResult<i32> {
+        Err(Error::EINVAL)
+    }
+
+    /// Handles ioctls defined with the `_IOWR` macro, that is, with a buffer for both input and
+    /// output provided as argument.
+    fn read_write(&self, _file: &File, _cmd: u32, _data: UserSlicePtr) -> KernelResult<i32> {
+        Err(Error::EINVAL)
+    }
+}
+
+/// Represents an ioctl command.
+///
+/// It can use the components of an ioctl command to dispatch ioctls using
+/// [`IoctlCommand::dispatch`].
+pub struct IoctlCommand {
+    cmd: u32,
+    arg: usize,
+    user_slice: Option<UserSlicePtr>,
+}
+
+impl IoctlCommand {
+    /// Constructs a new [`IoctlCommand`].
+    fn new(cmd: u32, arg: usize) -> Self {
+        let size = (cmd >> bindings::_IOC_SIZESHIFT) & bindings::_IOC_SIZEMASK;
+
+        // SAFETY: We only create one instance of the user slice per ioctl call, so TOCTOU issues
+        // are not possible.
+        let user_slice = Some(unsafe { UserSlicePtr::new(arg as _, size as _) });
+        Self {
+            cmd,
+            arg,
+            user_slice,
+        }
+    }
+
+    /// Dispatches the given ioctl to the appropriate handler based on the value of the command. It
+    /// also creates a [`UserSlicePtr`], [`UserSlicePtrReader`], or [`UserSlicePtrWriter`]
+    /// depending on the direction of the buffer of the command.
+    ///
+    /// It is meant to be used in implementations of [`FileOperations::ioctl`] and
+    /// [`FileOperations::compat_ioctl`].
+    pub fn dispatch<T: IoctlHandler>(&mut self, handler: &T, file: &File) -> KernelResult<i32> {
+        let dir = (self.cmd >> bindings::_IOC_DIRSHIFT) & bindings::_IOC_DIRMASK;
+        if dir == bindings::_IOC_NONE {
+            return handler.pure(file, self.cmd, self.arg);
+        }
+
+        let data = self.user_slice.take().ok_or(Error::EINVAL)?;
+        const READ_WRITE: u32 = bindings::_IOC_READ | bindings::_IOC_WRITE;
+        match dir {
+            bindings::_IOC_WRITE => handler.write(file, self.cmd, &mut data.reader()),
+            bindings::_IOC_READ => handler.read(file, self.cmd, &mut data.writer()),
+            READ_WRITE => handler.read_write(file, self.cmd, data),
+            _ => Err(Error::EINVAL),
+        }
+    }
+
+    /// Returns the raw 32-bit value of the command and the ptr-sized argument.
+    pub fn raw(&self) -> (u32, usize) {
+        (self.cmd, self.arg)
+    }
+}
+
+/// Trait for extracting file open arguments from kernel data structures.
+///
+/// This is meant to be implemented by registration managers.
+pub trait FileOpenAdapter {
+    /// The type of argument this adapter extracts.
+    type Arg;
+
+    /// Converts untyped data stored in [`struct inode`] and [`struct file`] (when [`struct
+    /// file_operations::open`] is called) into the given type. For example, for `miscdev`
+    /// devices, a pointer to the registered [`struct miscdev`] is stored in [`struct
+    /// file::private_data`].
+    ///
+    /// # Safety
+    ///
+    /// This function must be called only when [`struct file_operations::open`] is being called for
+    /// a file that was registered by the implementer.
+    unsafe fn convert(_inode: *mut bindings::inode, _file: *mut bindings::file)
+        -> *const Self::Arg;
+}
+
+/// Trait for implementers of kernel files.
+///
+/// In addition to the methods in [`FileOperations`], implementers must also provide
+/// [`FileOpener::open`] with a customised argument. This allows a single implementation of
+/// [`FileOperations`] to be used for different types of registrations, for example, `miscdev` and
+/// `chrdev`.
+pub trait FileOpener<T: ?Sized>: FileOperations {
+    /// Creates a new instance of this file.
+    ///
+    /// Corresponds to the `open` function pointer in `struct file_operations`.
+    fn open(context: &T) -> KernelResult<Self::Wrapper>;
+}
+
+/// Corresponds to the kernel's `struct file_operations`.
+///
+/// You implement this trait whenever you would create a `struct file_operations`.
+///
+/// File descriptors may be used from multiple threads/processes concurrently, so your type must be
+/// [`Sync`]. It must also be [`Send`] because [`FileOperations::release`] will be called from the
+/// thread that decrements that associated file's refcount to zero.
+pub trait FileOperations: Send + Sync + Sized {
+    /// The methods to use to populate [`struct file_operations`].
+    const TO_USE: ToUse;
+
+    /// The pointer type that will be used to hold ourselves.
+    type Wrapper: PointerWrapper<Self>;
+
+    /// Cleans up after the last reference to the file goes away.
+    ///
+    /// Note that the object is moved, so it will be freed automatically unless the implementation
+    /// moves it elsewhere.
+    ///
+    /// Corresponds to the `release` function pointer in `struct file_operations`.
+    fn release(_obj: Self::Wrapper, _file: &File) {}
+
+    /// Reads data from this file to userspace.
+    ///
+    /// Corresponds to the `read` function pointer in `struct file_operations`.
+    fn read(
+        &self,
+        _file: &File,
+        _data: &mut UserSlicePtrWriter,
+        _offset: u64,
+    ) -> KernelResult<usize> {
+        Err(Error::EINVAL)
+    }
+
+    /// Writes data from userspace to this file.
+    ///
+    /// Corresponds to the `write` function pointer in `struct file_operations`.
+    fn write(&self, _data: &mut UserSlicePtrReader, _offset: u64) -> KernelResult<usize> {
+        Err(Error::EINVAL)
+    }
+
+    /// Changes the position of the file.
+    ///
+    /// Corresponds to the `llseek` function pointer in `struct file_operations`.
+    fn seek(&self, _file: &File, _offset: SeekFrom) -> KernelResult<u64> {
+        Err(Error::EINVAL)
+    }
+
+    /// Performs IO control operations that are specific to the file.
+    ///
+    /// Corresponds to the `unlocked_ioctl` function pointer in `struct file_operations`.
+    fn ioctl(&self, _file: &File, _cmd: &mut IoctlCommand) -> KernelResult<i32> {
+        Err(Error::EINVAL)
+    }
+
+    /// Performs 32-bit IO control operations on that are specific to the file on 64-bit kernels.
+    ///
+    /// Corresponds to the `compat_ioctl` function pointer in `struct file_operations`.
+    fn compat_ioctl(&self, _file: &File, _cmd: &mut IoctlCommand) -> KernelResult<i32> {
+        Err(Error::EINVAL)
+    }
+
+    /// Syncs pending changes to this file.
+    ///
+    /// Corresponds to the `fsync` function pointer in `struct file_operations`.
+    fn fsync(&self, _file: &File, _start: u64, _end: u64, _datasync: bool) -> KernelResult<u32> {
+        Err(Error::EINVAL)
+    }
+
+    /// Maps areas of the caller's virtual memory with device/file memory.
+    ///
+    /// Corresponds to the `mmap` function pointer in `struct file_operations`.
+    /// TODO: wrap `vm_area_struct` so that we don't have to expose it.
+    fn mmap(&self, _file: &File, _vma: &mut bindings::vm_area_struct) -> KernelResult {
+        Err(Error::EINVAL)
+    }
+
+    /// Checks the state of the file and optionally registers for notification when the state
+    /// changes.
+    ///
+    /// Corresponds to the `poll` function pointer in `struct file_operations`.
+    fn poll(&self, _file: &File, _table: &PollTable) -> KernelResult<u32> {
+        Ok(bindings::POLLIN | bindings::POLLOUT | bindings::POLLRDNORM | bindings::POLLWRNORM)
+    }
+}
+
+/// Used to convert an object into a raw pointer that represents it.
+///
+/// It can eventually be converted back into the object. This is used to store objects as pointers
+/// in kernel data structures, for example, an implementation of [`FileOperations`] in `struct
+/// file::private_data`.
+pub trait PointerWrapper<T> {
+    /// Returns the raw pointer.
+    fn into_pointer(self) -> *const T;
+
+    /// Returns the instance back from the raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// The passed pointer must come from a previous call to [`PointerWrapper::into_pointer()`].
+    unsafe fn from_pointer(ptr: *const T) -> Self;
+}
+
+impl<T> PointerWrapper<T> for Box<T> {
+    fn into_pointer(self) -> *const T {
+        Box::into_raw(self)
+    }
+
+    unsafe fn from_pointer(ptr: *const T) -> Self {
+        Box::from_raw(ptr as _)
+    }
+}
+
+impl<T: RefCounted> PointerWrapper<T> for Ref<T> {
+    fn into_pointer(self) -> *const T {
+        Ref::into_raw(self)
+    }
+
+    unsafe fn from_pointer(ptr: *const T) -> Self {
+        Ref::from_raw(ptr as _)
+    }
+}
+
+impl<T> PointerWrapper<T> for Arc<T> {
+    fn into_pointer(self) -> *const T {
+        Arc::into_raw(self)
+    }
+
+    unsafe fn from_pointer(ptr: *const T) -> Self {
+        Arc::from_raw(ptr)
+    }
+}
+
+impl<T, W: PointerWrapper<T> + Deref> PointerWrapper<T> for Pin<W> {
+    fn into_pointer(self) -> *const T {
+        // SAFETY: We continue to treat the pointer as pinned by returning just a pointer to it to
+        // the caller.
+        let inner = unsafe { Pin::into_inner_unchecked(self) };
+        inner.into_pointer()
+    }
+
+    unsafe fn from_pointer(p: *const T) -> Self {
+        // SAFETY: The object was originally pinned.
+        Pin::new_unchecked(W::from_pointer(p))
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
new file mode 100644
index 000000000000..9a06bd60d5c1
--- /dev/null
+++ b/rust/kernel/lib.rs
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! The `kernel` crate.
+//!
+//! This crate contains the kernel APIs that have been ported or wrapped for
+//! usage by Rust code in the kernel and is shared by all of them.
+//!
+//! In other words, all the rest of the Rust code in the kernel (e.g. kernel
+//! modules written in Rust) depends on [`core`], [`alloc`] and this crate.
+//!
+//! If you need a kernel C API that is not ported or wrapped yet here, then
+//! do so first instead of bypassing this crate.
+
+#![no_std]
+#![feature(
+    allocator_api,
+    alloc_error_handler,
+    const_fn,
+    const_mut_refs,
+    const_panic,
+    try_reserve
+)]
+#![deny(clippy::complexity)]
+#![deny(clippy::correctness)]
+#![deny(clippy::perf)]
+#![deny(clippy::style)]
+
+// Ensure conditional compilation based on the kernel configuration works;
+// otherwise we may silently break things like initcall handling.
+#[cfg(not(CONFIG_RUST))]
+compile_error!("Missing kernel configuration for conditional compilation");
+
+mod allocator;
+
+#[doc(hidden)]
+pub mod bindings;
+
+pub mod buffer;
+pub mod c_types;
+pub mod chrdev;
+mod error;
+pub mod file_operations;
+pub mod miscdev;
+
+#[doc(hidden)]
+pub mod module_param;
+
+pub mod prelude;
+pub mod print;
+pub mod random;
+mod static_assert;
+pub mod sync;
+
+#[cfg(CONFIG_SYSCTL)]
+pub mod sysctl;
+
+mod types;
+pub mod user_ptr;
+
+pub use crate::error::{Error, KernelResult};
+pub use crate::types::{CStr, Mode};
+
+/// Page size defined in terms of the `PAGE_SHIFT` macro from C.
+///
+/// [`PAGE_SHIFT`]: ../../../include/asm-generic/page.h
+pub const PAGE_SIZE: usize = 1 << bindings::PAGE_SHIFT;
+
+/// The top level entrypoint to implementing a kernel module.
+///
+/// For any teardown or cleanup operations, your type may implement [`Drop`].
+pub trait KernelModule: Sized + Sync {
+    /// Called at module initialization time.
+    ///
+    /// Use this method to perform whatever setup or registration your module
+    /// should do.
+    ///
+    /// Equivalent to the `module_init` macro in the C API.
+    fn init() -> KernelResult<Self>;
+}
+
+/// Equivalent to `THIS_MODULE` in the C API.
+///
+/// C header: `include/linux/export.h`
+pub struct ThisModule(*mut bindings::module);
+
+// SAFETY: `THIS_MODULE` may be used from all threads within a module.
+unsafe impl Sync for ThisModule {}
+
+impl ThisModule {
+    /// Creates a [`ThisModule`] given the `THIS_MODULE` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must be equal to the right `THIS_MODULE`.
+    pub const unsafe fn from_ptr(ptr: *mut bindings::module) -> ThisModule {
+        ThisModule(ptr)
+    }
+
+    /// Locks the module parameters to access them.
+    ///
+    /// Returns a [`KParamGuard`] that will release the lock when dropped.
+    pub fn kernel_param_lock(&self) -> KParamGuard<'_> {
+        // SAFETY: `kernel_param_lock` will check if the pointer is null and
+        // use the built-in mutex in that case.
+        #[cfg(CONFIG_SYSFS)]
+        unsafe {
+            bindings::kernel_param_lock(self.0)
+        }
+
+        KParamGuard { this_module: self }
+    }
+}
+
+/// Scoped lock on the kernel parameters of [`ThisModule`].
+///
+/// Lock will be released when this struct is dropped.
+pub struct KParamGuard<'a> {
+    this_module: &'a ThisModule,
+}
+
+#[cfg(CONFIG_SYSFS)]
+impl<'a> Drop for KParamGuard<'a> {
+    fn drop(&mut self) {
+        // SAFETY: `kernel_param_lock` will check if the pointer is null and
+        // use the built-in mutex in that case. The existance of `self`
+        // guarantees that the lock is held.
+        unsafe { bindings::kernel_param_unlock(self.this_module.0) }
+    }
+}
+
+/// Calculates the offset of a field from the beginning of the struct it belongs to.
+///
+/// # Example
+///
+/// ```
+/// struct Test {
+///     a: u64,
+///     b: u32,
+/// }
+///
+/// fn test() {
+///     // This prints `8`.
+///     pr_info!("{}\n", offset_of!(Test, b));
+/// }
+/// ```
+#[macro_export]
+macro_rules! offset_of {
+    ($type:ty, $($f:tt)*) => {{
+        let tmp = core::mem::MaybeUninit::<$type>::uninit();
+        let outer = tmp.as_ptr();
+        // To avoid warnings when nesting `unsafe` blocks.
+        #[allow(unused_unsafe)]
+        // SAFETY: The pointer is valid and aligned, just not initialised; `addr_of` ensures that
+        // we don't actually read from `outer` (which would be UB) nor create an intermediate
+        // reference.
+        let inner = unsafe { core::ptr::addr_of!((*outer).$($f)*) } as *const u8;
+        // To avoid warnings when nesting `unsafe` blocks.
+        #[allow(unused_unsafe)]
+        // SAFETY: The two pointers are within the same allocation block.
+        unsafe { inner.offset_from(outer as *const u8) }
+    }}
+}
+
+/// Produces a pointer to an object from a pointer to one of its fields.
+///
+/// # Safety
+///
+/// Callers must ensure that the pointer to the field is in fact a pointer to the specified field,
+/// as opposed to a pointer to another object of the same type.
+///
+/// # Example
+///
+/// ```
+/// struct Test {
+///     a: u64,
+///     b: u32,
+/// }
+///
+/// fn test() {
+///     let test = Test { a: 10, b: 20 };
+///     let b_ptr = &test.b;
+///     let test_alias = unsafe { container_of!(b_ptr, Test, b) };
+///     // This prints `true`.
+///     pr_info!("{}\n", core::ptr::eq(&test, test_alias));
+/// }
+/// ```
+#[macro_export]
+macro_rules! container_of {
+    ($ptr:expr, $type:ty, $($f:tt)*) => {{
+        let offset = $crate::offset_of!($type, $($f)*);
+        ($ptr as *const _ as *const u8).offset(-offset) as *const $type
+    }}
+}
+
+#[global_allocator]
+static ALLOCATOR: allocator::KernelAllocator = allocator::KernelAllocator;
diff --git a/rust/kernel/miscdev.rs b/rust/kernel/miscdev.rs
new file mode 100644
index 000000000000..92c2181f3053
--- /dev/null
+++ b/rust/kernel/miscdev.rs
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Miscellaneous devices.
+//!
+//! C header: [`include/linux/miscdevice.h`](../../../../include/linux/miscdevice.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/driver-api/misc_devices.html>
+
+use crate::error::{Error, KernelResult};
+use crate::file_operations::{FileOpenAdapter, FileOpener, FileOperationsVtable};
+use crate::{bindings, c_types, CStr};
+use alloc::boxed::Box;
+use core::marker::PhantomPinned;
+use core::pin::Pin;
+
+/// A registration of a miscellaneous device.
+pub struct Registration<T: Sync = ()> {
+    registered: bool,
+    mdev: bindings::miscdevice,
+    _pin: PhantomPinned,
+
+    /// Context initialised on construction and made available to all file instances on
+    /// [`FileOpener::open`].
+    pub context: T,
+}
+
+impl<T: Sync> Registration<T> {
+    /// Creates a new [`Registration`] but does not register it yet.
+    ///
+    /// It is allowed to move.
+    pub fn new(context: T) -> Self {
+        Self {
+            registered: false,
+            mdev: bindings::miscdevice::default(),
+            _pin: PhantomPinned,
+            context,
+        }
+    }
+
+    /// Registers a miscellaneous device.
+    ///
+    /// Returns a pinned heap-allocated representation of the registration.
+    pub fn new_pinned<F: FileOpener<T>>(
+        name: CStr<'static>,
+        minor: Option<i32>,
+        context: T,
+    ) -> KernelResult<Pin<Box<Self>>> {
+        let mut r = Pin::from(Box::try_new(Self::new(context))?);
+        r.as_mut().register::<F>(name, minor)?;
+        Ok(r)
+    }
+
+    /// Registers a miscellaneous device with the rest of the kernel.
+    ///
+    /// It must be pinned because the memory block that represents the registration is
+    /// self-referential. If a minor is not given, the kernel allocates a new one if possible.
+    pub fn register<F: FileOpener<T>>(
+        self: Pin<&mut Self>,
+        name: CStr<'static>,
+        minor: Option<i32>,
+    ) -> KernelResult {
+        // SAFETY: We must ensure that we never move out of `this`.
+        let this = unsafe { self.get_unchecked_mut() };
+        if this.registered {
+            // Already registered.
+            return Err(Error::EINVAL);
+        }
+
+        // SAFETY: The adapter is compatible with `misc_register`.
+        this.mdev.fops = unsafe { FileOperationsVtable::<Self, F>::build() };
+        this.mdev.name = name.as_ptr() as *const c_types::c_char;
+        this.mdev.minor = minor.unwrap_or(bindings::MISC_DYNAMIC_MINOR as i32);
+
+        let ret = unsafe { bindings::misc_register(&mut this.mdev) };
+        if ret < 0 {
+            return Err(Error::from_kernel_errno(ret));
+        }
+        this.registered = true;
+        Ok(())
+    }
+}
+
+impl<T: Sync> FileOpenAdapter for Registration<T> {
+    type Arg = T;
+
+    unsafe fn convert(_inode: *mut bindings::inode, file: *mut bindings::file) -> *const Self::Arg {
+        let reg = crate::container_of!((*file).private_data, Self, mdev);
+        &(*reg).context
+    }
+}
+
+// SAFETY: The only method is `register()`, which requires a (pinned) mutable `Registration`, so it
+// is safe to pass `&Registration` to multiple threads because it offers no interior mutability,
+// except maybe through `Registration::context`, but it is itself `Sync`.
+unsafe impl<T: Sync> Sync for Registration<T> {}
+
+// SAFETY: All functions work from any thread. So as long as the `Registration::context` is
+// `Send`, so is `Registration<T>`. `T` needs to be `Sync` because it's a requirement of
+// `Registration<T>`.
+unsafe impl<T: Send + Sync> Send for Registration<T> {}
+
+impl<T: Sync> Drop for Registration<T> {
+    /// Removes the registration from the kernel if it has completed successfully before.
+    fn drop(&mut self) {
+        if self.registered {
+            unsafe { bindings::misc_deregister(&mut self.mdev) }
+        }
+    }
+}
diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
new file mode 100644
index 000000000000..e8d51fe613f5
--- /dev/null
+++ b/rust/kernel/module_param.rs
@@ -0,0 +1,497 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for module parameters.
+//!
+//! C header: [`include/linux/moduleparam.h`](../../../include/linux/moduleparam.h)
+
+use core::fmt::Write;
+
+/// Types that can be used for module parameters.
+///
+/// Note that displaying the type in `sysfs` will fail if
+/// [`alloc::string::ToString::to_string`] (as implemented through the
+/// [`core::fmt::Display`] trait) writes more than [`PAGE_SIZE`]
+/// bytes (including an additional null terminator).
+///
+/// [`PAGE_SIZE`]: `crate::PAGE_SIZE`
+pub trait ModuleParam: core::fmt::Display + core::marker::Sized {
+    /// The `ModuleParam` will be used by the kernel module through this type.
+    ///
+    /// This may differ from `Self` if, for example, `Self` needs to track
+    /// ownership without exposing it or allocate extra space for other possible
+    /// parameter values. See [`StringParam`] or [`ArrayParam`] for examples.
+    type Value: ?Sized;
+
+    /// Whether the parameter is allowed to be set without an argument.
+    ///
+    /// Setting this to `true` allows the parameter to be passed without an
+    /// argument (e.g. just `module.param` instead of `module.param=foo`).
+    const NOARG_ALLOWED: bool;
+
+    /// Convert a parameter argument into the parameter value.
+    ///
+    /// `None` should be returned when parsing of the argument fails.
+    /// `arg == None` indicates that the parameter was passed without an
+    /// argument. If `NOARG_ALLOWED` is set to `false` then `arg` is guaranteed
+    /// to always be `Some(_)`.
+    ///
+    /// Parameters passed at boot time will be set before [`kmalloc`] is
+    /// available (even if the module is loaded at a later time). However, in
+    /// this case, the argument buffer will be valid for the entire lifetime of
+    /// the kernel. So implementations of this method which need to allocate
+    /// should first check that the allocator is available (with
+    /// [`crate::bindings::slab_is_available`]) and when it is not available
+    /// provide an alternative implementation which doesn't allocate. In cases
+    /// where the allocator is not available it is safe to save references to
+    /// `arg` in `Self`, but in other cases a copy should be made.
+    ///
+    /// [`kmalloc`]: ../../../include/linux/slab.h
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self>;
+
+    /// Get the current value of the parameter for use in the kernel module.
+    ///
+    /// This function should not be used directly. Instead use the wrapper
+    /// `read` which will be generated by [`module::module`].
+    fn value(&self) -> &Self::Value;
+
+    /// Set the module parameter from a string.
+    ///
+    /// Used to set the parameter value when loading the module or when set
+    /// through `sysfs`.
+    ///
+    /// # Safety
+    ///
+    /// If `val` is non-null then it must point to a valid null-terminated
+    /// string. The `arg` field of `param` must be an instance of `Self`.
+    unsafe extern "C" fn set_param(
+        val: *const crate::c_types::c_char,
+        param: *const crate::bindings::kernel_param,
+    ) -> crate::c_types::c_int {
+        let arg = if val.is_null() {
+            None
+        } else {
+            Some(crate::c_types::c_string_bytes(val))
+        };
+        match Self::try_from_param_arg(arg) {
+            Some(new_value) => {
+                let old_value = (*param).__bindgen_anon_1.arg as *mut Self;
+                let _ = core::ptr::replace(old_value, new_value);
+                0
+            }
+            None => crate::error::Error::EINVAL.to_kernel_errno(),
+        }
+    }
+
+    /// Write a string representation of the current parameter value to `buf`.
+    ///
+    /// Used for displaying the current parameter value in `sysfs`.
+    ///
+    /// # Safety
+    ///
+    /// `buf` must be a buffer of length at least `kernel::PAGE_SIZE` that is
+    /// writeable. The `arg` field of `param` must be an instance of `Self`.
+    unsafe extern "C" fn get_param(
+        buf: *mut crate::c_types::c_char,
+        param: *const crate::bindings::kernel_param,
+    ) -> crate::c_types::c_int {
+        let slice = core::slice::from_raw_parts_mut(buf as *mut u8, crate::PAGE_SIZE);
+        let mut buf = crate::buffer::Buffer::new(slice);
+        match write!(buf, "{}\0", *((*param).__bindgen_anon_1.arg as *mut Self)) {
+            Err(_) => crate::error::Error::EINVAL.to_kernel_errno(),
+            Ok(()) => buf.bytes_written() as crate::c_types::c_int,
+        }
+    }
+
+    /// Drop the parameter.
+    ///
+    /// Called when unloading a module.
+    ///
+    /// # Safety
+    ///
+    /// The `arg` field of `param` must be an instance of `Self`.
+    unsafe extern "C" fn free(arg: *mut crate::c_types::c_void) {
+        core::ptr::drop_in_place(arg as *mut Self);
+    }
+}
+
+/// Trait for parsing integers.
+///
+/// Strings begining with `0x`, `0o`, or `0b` are parsed as hex, octal, or
+/// binary respectively. Strings beginning with `0` otherwise are parsed as
+/// octal. Anything else is parsed as decimal. A leading `+` or `-` is also
+/// permitted. Any string parsed by [`kstrtol()`] or [`kstrtoul()`] will be
+/// successfully parsed.
+///
+/// [`kstrtol()`]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.kstrtol
+/// [`kstrtoul()`]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.kstrtoul
+trait ParseInt: Sized {
+    fn from_str_radix(src: &str, radix: u32) -> Result<Self, core::num::ParseIntError>;
+    fn checked_neg(self) -> Option<Self>;
+
+    fn from_str_unsigned(src: &str) -> Result<Self, core::num::ParseIntError> {
+        let (radix, digits) = if let Some(n) = src.strip_prefix("0x") {
+            (16, n)
+        } else if let Some(n) = src.strip_prefix("0X") {
+            (16, n)
+        } else if let Some(n) = src.strip_prefix("0o") {
+            (8, n)
+        } else if let Some(n) = src.strip_prefix("0O") {
+            (8, n)
+        } else if let Some(n) = src.strip_prefix("0b") {
+            (2, n)
+        } else if let Some(n) = src.strip_prefix("0B") {
+            (2, n)
+        } else if src.starts_with('0') {
+            (8, src)
+        } else {
+            (10, src)
+        };
+        Self::from_str_radix(digits, radix)
+    }
+
+    fn from_str(src: &str) -> Option<Self> {
+        match src.bytes().next() {
+            None => None,
+            Some(b'-') => Self::from_str_unsigned(&src[1..]).ok()?.checked_neg(),
+            Some(b'+') => Some(Self::from_str_unsigned(&src[1..]).ok()?),
+            Some(_) => Some(Self::from_str_unsigned(src).ok()?),
+        }
+    }
+}
+
+macro_rules! impl_parse_int {
+    ($ty:ident) => {
+        impl ParseInt for $ty {
+            fn from_str_radix(src: &str, radix: u32) -> Result<Self, core::num::ParseIntError> {
+                $ty::from_str_radix(src, radix)
+            }
+
+            fn checked_neg(self) -> Option<Self> {
+                self.checked_neg()
+            }
+        }
+    };
+}
+
+impl_parse_int!(i8);
+impl_parse_int!(u8);
+impl_parse_int!(i16);
+impl_parse_int!(u16);
+impl_parse_int!(i32);
+impl_parse_int!(u32);
+impl_parse_int!(i64);
+impl_parse_int!(u64);
+impl_parse_int!(isize);
+impl_parse_int!(usize);
+
+macro_rules! impl_module_param {
+    ($ty:ident) => {
+        impl ModuleParam for $ty {
+            type Value = $ty;
+
+            const NOARG_ALLOWED: bool = false;
+
+            fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+                let bytes = arg?;
+                let utf8 = core::str::from_utf8(bytes).ok()?;
+                <$ty as crate::module_param::ParseInt>::from_str(utf8)
+            }
+
+            fn value(&self) -> &Self::Value {
+                self
+            }
+        }
+    };
+}
+
+#[doc(hidden)]
+#[macro_export]
+/// Generate a static [`kernel_param_ops`](../../../include/linux/moduleparam.h) struct.
+///
+/// # Example
+/// ```rust
+/// make_param_ops!(
+///     /// Documentation for new param ops.
+///     PARAM_OPS_MYTYPE, // Name for the static.
+///     MyType // A type which implements [`ModuleParam`].
+/// );
+/// ```
+macro_rules! make_param_ops {
+    ($ops:ident, $ty:ty) => {
+        $crate::make_param_ops!(
+            #[doc=""]
+            $ops,
+            $ty
+        );
+    };
+    ($(#[$meta:meta])* $ops:ident, $ty:ty) => {
+        $(#[$meta])*
+        ///
+        /// Static [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+        /// struct generated by [`make_param_ops`].
+        pub static $ops: $crate::bindings::kernel_param_ops = $crate::bindings::kernel_param_ops {
+            flags: if <$ty as $crate::module_param::ModuleParam>::NOARG_ALLOWED {
+                $crate::bindings::KERNEL_PARAM_OPS_FL_NOARG
+            } else {
+                0
+            },
+            set: Some(<$ty as $crate::module_param::ModuleParam>::set_param),
+            get: Some(<$ty as $crate::module_param::ModuleParam>::get_param),
+            free: Some(<$ty as $crate::module_param::ModuleParam>::free),
+        };
+    };
+}
+
+impl_module_param!(i8);
+impl_module_param!(u8);
+impl_module_param!(i16);
+impl_module_param!(u16);
+impl_module_param!(i32);
+impl_module_param!(u32);
+impl_module_param!(i64);
+impl_module_param!(u64);
+impl_module_param!(isize);
+impl_module_param!(usize);
+
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i8`].
+    PARAM_OPS_I8,
+    i8
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u8`].
+    PARAM_OPS_U8,
+    u8
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i16`].
+    PARAM_OPS_I16,
+    i16
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u16`].
+    PARAM_OPS_U16,
+    u16
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i32`].
+    PARAM_OPS_I32,
+    i32
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u32`].
+    PARAM_OPS_U32,
+    u32
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i64`].
+    PARAM_OPS_I64,
+    i64
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u64`].
+    PARAM_OPS_U64,
+    u64
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`isize`].
+    PARAM_OPS_ISIZE,
+    isize
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`usize`].
+    PARAM_OPS_USIZE,
+    usize
+);
+
+impl ModuleParam for bool {
+    type Value = bool;
+
+    const NOARG_ALLOWED: bool = true;
+
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+        match arg {
+            None => Some(true),
+            Some(b"y") | Some(b"Y") | Some(b"1") | Some(b"true") => Some(true),
+            Some(b"n") | Some(b"N") | Some(b"0") | Some(b"false") => Some(false),
+            _ => None,
+        }
+    }
+
+    fn value(&self) -> &Self::Value {
+        self
+    }
+}
+
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`bool`].
+    PARAM_OPS_BOOL,
+    bool
+);
+
+/// An array of at __most__ `N` values.
+///
+/// # Invariant
+///
+/// The first `self.used` elements of `self.values` are initialized.
+pub struct ArrayParam<T, const N: usize> {
+    values: [core::mem::MaybeUninit<T>; N],
+    used: usize,
+}
+
+impl<T, const N: usize> ArrayParam<T, { N }> {
+    fn values(&self) -> &[T] {
+        // SAFETY: The invariant maintained by `ArrayParam` allows us to cast
+        // the first `self.used` elements to `T`.
+        unsafe {
+            &*(&self.values[0..self.used] as *const [core::mem::MaybeUninit<T>] as *const [T])
+        }
+    }
+}
+
+impl<T: Copy, const N: usize> ArrayParam<T, { N }> {
+    const fn new() -> Self {
+        // INVARIANT: The first `self.used` elements of `self.values` are
+        // initialized.
+        ArrayParam {
+            values: [core::mem::MaybeUninit::uninit(); N],
+            used: 0,
+        }
+    }
+
+    const fn push(&mut self, val: T) {
+        if self.used < N {
+            // INVARIANT: The first `self.used` elements of `self.values` are
+            // initialized.
+            self.values[self.used] = core::mem::MaybeUninit::new(val);
+            self.used += 1;
+        }
+    }
+
+    /// Create an instance of `ArrayParam` initialized with `vals`.
+    ///
+    /// This function is only meant to be used in the [`module::module`] macro.
+    pub const fn create(vals: &[T]) -> Self {
+        let mut result = ArrayParam::new();
+        let mut i = 0;
+        while i < vals.len() {
+            result.push(vals[i]);
+            i += 1;
+        }
+        result
+    }
+}
+
+impl<T: core::fmt::Display, const N: usize> core::fmt::Display for ArrayParam<T, { N }> {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        for val in self.values() {
+            write!(f, "{},", val)?;
+        }
+        Ok(())
+    }
+}
+
+impl<T: Copy + core::fmt::Display + ModuleParam, const N: usize> ModuleParam
+    for ArrayParam<T, { N }>
+{
+    type Value = [T];
+
+    const NOARG_ALLOWED: bool = false;
+
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+        arg.and_then(|args| {
+            let mut result = Self::new();
+            for arg in args.split(|b| *b == b',') {
+                result.push(T::try_from_param_arg(Some(arg))?);
+            }
+            Some(result)
+        })
+    }
+
+    fn value(&self) -> &Self::Value {
+        self.values()
+    }
+}
+
+/// A C-style string parameter.
+///
+/// The Rust version of the [`charp`] parameter. This type is meant to be
+/// used by the [`module::module`] macro, not handled directly. Instead use the
+/// `read` method generated by that macro.
+///
+/// [`charp`]: ../../../include/linux/moduleparam.h
+pub enum StringParam {
+    /// A borrowed parameter value.
+    ///
+    /// Either the default value (which is static in the module) or borrowed
+    /// from the original argument buffer used to set the value.
+    Ref(&'static [u8]),
+
+    /// A value that was allocated when the parameter was set.
+    ///
+    /// The value needs to be freed when the parameter is reset or the module is
+    /// unloaded.
+    Owned(alloc::vec::Vec<u8>),
+}
+
+impl StringParam {
+    fn bytes(&self) -> &[u8] {
+        match self {
+            StringParam::Ref(bytes) => *bytes,
+            StringParam::Owned(vec) => &vec[..],
+        }
+    }
+}
+
+impl core::fmt::Display for StringParam {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        let bytes = self.bytes();
+        match core::str::from_utf8(bytes) {
+            Ok(utf8) => write!(f, "{}", utf8),
+            Err(_) => write!(f, "{:?}", bytes),
+        }
+    }
+}
+
+impl ModuleParam for StringParam {
+    type Value = [u8];
+
+    const NOARG_ALLOWED: bool = false;
+
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+        // SAFETY: It is always safe to call [`slab_is_available`](../../../include/linux/slab.h).
+        let slab_available = unsafe { crate::bindings::slab_is_available() };
+        arg.and_then(|arg| {
+            if slab_available {
+                let mut vec = alloc::vec::Vec::new();
+                vec.try_reserve_exact(arg.len()).ok()?;
+                vec.extend_from_slice(arg);
+                Some(StringParam::Owned(vec))
+            } else {
+                Some(StringParam::Ref(arg))
+            }
+        })
+    }
+
+    fn value(&self) -> &Self::Value {
+        self.bytes()
+    }
+}
+
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`StringParam`].
+    PARAM_OPS_STR,
+    StringParam
+);
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
new file mode 100644
index 000000000000..06046bf18a4a
--- /dev/null
+++ b/rust/kernel/prelude.rs
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! The `kernel` prelude.
+//!
+//! These are most common items used by Rust code in the kernel, intended to
+//! be imported by all Rust code, for convenience.
+//!
+//! # Examples
+//!
+//! ```rust,no_run
+//! use kernel::prelude::*;
+//! ```
+
+pub use alloc::{borrow::ToOwned, string::String};
+
+pub use module::module;
+
+pub use super::{pr_alert, pr_cont, pr_crit, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
+
+pub use super::static_assert;
+
+pub use super::{KernelModule, KernelResult};
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
new file mode 100644
index 000000000000..71a5ebe500d7
--- /dev/null
+++ b/rust/kernel/print.rs
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Printing facilities.
+//!
+//! C header: [`include/linux/printk.h`](../../../../include/linux/printk.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/core-api/printk-basics.html>
+
+use core::cmp;
+use core::fmt;
+
+use crate::bindings;
+use crate::c_types::c_int;
+
+/// Format strings.
+///
+/// Public but hidden since it should only be used from public macros.
+#[doc(hidden)]
+pub mod format_strings {
+    use crate::bindings;
+
+    /// The length we copy from the `KERN_*` kernel prefixes.
+    const LENGTH_PREFIX: usize = 2;
+
+    /// The length of the fixed format strings.
+    pub const LENGTH: usize = 11;
+
+    /// Generates a fixed format string for the kernel's [`printk`].
+    ///
+    /// The format string is always the same for a given level, i.e. for a
+    /// given `prefix`, which are the kernel's `KERN_*` constants.
+    ///
+    /// [`printk`]: ../../../../include/linux/printk.h
+    const fn generate(is_cont: bool, prefix: &[u8; 3]) -> [u8; LENGTH] {
+        // Ensure the `KERN_*` macros are what we expect.
+        assert!(prefix[0] == b'\x01');
+        if is_cont {
+            assert!(prefix[1] == b'c');
+        } else {
+            assert!(prefix[1] >= b'0' && prefix[1] <= b'7');
+        }
+        assert!(prefix[2] == b'\x00');
+
+        let suffix: &[u8; LENGTH - LENGTH_PREFIX] = if is_cont {
+            b"%.*s\0\0\0\0\0"
+        } else {
+            b"%s: %.*s\0"
+        };
+
+        [
+            prefix[0], prefix[1], suffix[0], suffix[1], suffix[2], suffix[3], suffix[4], suffix[5],
+            suffix[6], suffix[7], suffix[8],
+        ]
+    }
+
+    // Generate the format strings at compile-time.
+    //
+    // This avoids the compiler generating the contents on the fly in the stack.
+    //
+    // Furthermore, `static` instead of `const` is used to share the strings
+    // for all the kernel.
+    pub static EMERG: [u8; LENGTH] = generate(false, bindings::KERN_EMERG);
+    pub static ALERT: [u8; LENGTH] = generate(false, bindings::KERN_ALERT);
+    pub static CRIT: [u8; LENGTH] = generate(false, bindings::KERN_CRIT);
+    pub static ERR: [u8; LENGTH] = generate(false, bindings::KERN_ERR);
+    pub static WARNING: [u8; LENGTH] = generate(false, bindings::KERN_WARNING);
+    pub static NOTICE: [u8; LENGTH] = generate(false, bindings::KERN_NOTICE);
+    pub static INFO: [u8; LENGTH] = generate(false, bindings::KERN_INFO);
+    pub static DEBUG: [u8; LENGTH] = generate(false, bindings::KERN_DEBUG);
+    pub static CONT: [u8; LENGTH] = generate(true, bindings::KERN_CONT);
+}
+
+/// Prints a message via the kernel's [`printk`].
+///
+/// Public but hidden since it should only be used from public macros.
+///
+/// # Safety
+///
+/// The format string must be one of the ones in [`format_strings`], and
+/// the module name must be null-terminated.
+///
+/// [`printk`]: ../../../../include/linux/printk.h
+#[doc(hidden)]
+pub unsafe fn call_printk(
+    format_string: &[u8; format_strings::LENGTH],
+    module_name: &[u8],
+    string: &[u8],
+) {
+    // `printk` does not seem to fail in any path.
+    bindings::printk(
+        format_string.as_ptr() as _,
+        module_name.as_ptr(),
+        string.len() as c_int,
+        string.as_ptr(),
+    );
+}
+
+/// Prints a message via the kernel's [`printk`] for the `CONT` level.
+///
+/// Public but hidden since it should only be used from public macros.
+///
+/// [`printk`]: ../../../../include/linux/printk.h
+#[doc(hidden)]
+pub fn call_printk_cont(string: &[u8]) {
+    // `printk` does not seem to fail in any path.
+    //
+    // SAFETY: The format string is fixed.
+    unsafe {
+        bindings::printk(
+            format_strings::CONT.as_ptr() as _,
+            string.len() as c_int,
+            string.as_ptr(),
+        );
+    }
+}
+
+/// The maximum size of a log line in the kernel.
+///
+/// From `kernel/printk/printk.c`.
+const LOG_LINE_MAX: usize = 1024 - 32;
+
+/// The maximum size of a log line in our side.
+///
+/// FIXME: We should be smarter than this, but for the moment, to reduce stack
+/// usage, we only allow this much which should work for most purposes.
+const LOG_LINE_SIZE: usize = 300;
+crate::static_assert!(LOG_LINE_SIZE <= LOG_LINE_MAX);
+
+/// Public but hidden since it should only be used from public macros.
+#[doc(hidden)]
+pub struct LogLineWriter {
+    data: [u8; LOG_LINE_SIZE],
+    pos: usize,
+}
+
+impl LogLineWriter {
+    /// Creates a new [`LogLineWriter`].
+    pub fn new() -> LogLineWriter {
+        LogLineWriter {
+            data: [0u8; LOG_LINE_SIZE],
+            pos: 0,
+        }
+    }
+
+    /// Returns the internal buffer as a byte slice.
+    pub fn as_bytes(&self) -> &[u8] {
+        &self.data[..self.pos]
+    }
+}
+
+impl Default for LogLineWriter {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl fmt::Write for LogLineWriter {
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        let copy_len = cmp::min(LOG_LINE_SIZE - self.pos, s.as_bytes().len());
+        self.data[self.pos..self.pos + copy_len].copy_from_slice(&s.as_bytes()[..copy_len]);
+        self.pos += copy_len;
+        Ok(())
+    }
+}
+
+/// Helper function for the [`print_macro!`] to reduce stack usage.
+///
+/// Public but hidden since it should only be used from public macros.
+///
+/// # Safety
+///
+/// The format string must be one of the ones in [`format_strings`], and
+/// the module name must be null-terminated.
+#[doc(hidden)]
+pub unsafe fn format_and_call<const CONT: bool>(
+    format_string: &[u8; format_strings::LENGTH],
+    module_name: &[u8],
+    args: fmt::Arguments,
+) {
+    // Careful: this object takes quite a bit of stack.
+    let mut writer = LogLineWriter::new();
+
+    match fmt::write(&mut writer, args) {
+        Ok(_) => {
+            if CONT {
+                call_printk_cont(writer.as_bytes());
+            } else {
+                call_printk(format_string, module_name, writer.as_bytes());
+            }
+        }
+
+        Err(_) => {
+            call_printk(
+                &format_strings::CRIT,
+                module_name,
+                b"Failure to format string.\n",
+            );
+        }
+    };
+}
+
+/// Performs formatting and forwards the string to [`call_printk`].
+///
+/// Public but hidden since it should only be used from public macros.
+#[doc(hidden)]
+#[macro_export]
+macro_rules! print_macro (
+    // Without extra arguments: no need to format anything.
+    ($format_string:path, false, $fmt:expr) => (
+        // SAFETY: This hidden macro should only be called by the documented
+        // printing macros which ensure the format string is one of the fixed
+        // ones. All `__MODULE_NAME`s are null-terminated as they are generated
+        // by the `module!` proc macro.
+        unsafe {
+            kernel::print::call_printk(
+                &$format_string,
+                crate::__MODULE_NAME,
+                $fmt.as_bytes(),
+            );
+        }
+    );
+
+    // Without extra arguments: no need to format anything (`CONT` case).
+    ($format_string:path, true, $fmt:expr) => (
+        kernel::print::call_printk_cont(
+            $fmt.as_bytes(),
+        );
+    );
+
+    // With extra arguments: we need to perform formatting.
+    ($format_string:path, $cont:literal, $fmt:expr, $($arg:tt)*) => (
+        // Forwarding the call to a function to perform the formatting
+        // is needed here to avoid stack overflows in non-optimized builds when
+        // invoking the printing macros a lot of times in the same function.
+        // Without it, the compiler reserves one `LogLineWriter` per macro
+        // invocation, which is a huge type.
+        //
+        // We could use an immediately-invoked closure for this, which
+        // seems to lower even more the stack usage at `opt-level=0` because
+        // `fmt::Arguments` objects do not pile up. However, that breaks
+        // the `?` operator if used in one of the arguments.
+        //
+        // At `opt-level=2`, the generated code is basically the same for
+        // all alternatives.
+        //
+        // SAFETY: This hidden macro should only be called by the documented
+        // printing macros which ensure the format string is one of the fixed
+        // ones. All `__MODULE_NAME`s are null-terminated as they are generated
+        // by the `module!` proc macro.
+        unsafe {
+            kernel::print::format_and_call::<$cont>(
+                &$format_string,
+                crate::__MODULE_NAME,
+                format_args!($fmt, $($arg)*),
+            );
+        }
+    );
+);
+
+// We could use a macro to generate these macros. However, doing so ends
+// up being a bit ugly: it requires the dollar token trick to escape `$` as
+// well as playing with the `doc` attribute. Furthermore, they cannot be easily
+// imported in the prelude due to [1]. So, for the moment, we just write them
+// manually, like in the C side; while keeping most of the logic in another
+// macro, i.e. [`print_macro`].
+//
+// [1]: https://github.com/rust-lang/rust/issues/52234
+
+/// Prints an emergency-level message (level 0).
+///
+/// Use this level if the system is unusable.
+///
+/// Equivalent to the kernel's [`pr_emerg`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_emerg`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_emerg
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_emerg!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_emerg (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::EMERG, false, $($arg)*)
+    )
+);
+
+/// Prints an alert-level message (level 1).
+///
+/// Use this level if action must be taken immediately.
+///
+/// Equivalent to the kernel's [`pr_alert`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_alert`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_alert
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_alert!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_alert (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::ALERT, false, $($arg)*)
+    )
+);
+
+/// Prints a critical-level message (level 2).
+///
+/// Use this level for critical conditions.
+///
+/// Equivalent to the kernel's [`pr_crit`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_crit`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_crit
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_crit!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_crit (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::CRIT, false, $($arg)*)
+    )
+);
+
+/// Prints an error-level message (level 3).
+///
+/// Use this level for error conditions.
+///
+/// Equivalent to the kernel's [`pr_err`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_err`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_err
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_err!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_err (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::ERR, false, $($arg)*)
+    )
+);
+
+/// Prints a warning-level message (level 4).
+///
+/// Use this level for warning conditions.
+///
+/// Equivalent to the kernel's [`pr_warn`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_warn`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_warn
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_warn!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_warn (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::WARNING, false, $($arg)*)
+    )
+);
+
+/// Prints a notice-level message (level 5).
+///
+/// Use this level for normal but significant conditions.
+///
+/// Equivalent to the kernel's [`pr_notice`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_notice`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_notice
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_notice!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_notice (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::NOTICE, false, $($arg)*)
+    )
+);
+
+/// Prints an info-level message (level 6).
+///
+/// Use this level for informational messages.
+///
+/// Equivalent to the kernel's [`pr_info`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_info`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_info
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_info!("hello {}\n", "there");
+/// ```
+#[macro_export]
+#[doc(alias = "print")]
+macro_rules! pr_info (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::INFO, false, $($arg)*)
+    )
+);
+
+/// Continues a previous log message in the same line.
+///
+/// Use only when continuing a previous `pr_*!` macro (e.g. [`pr_info!`]).
+///
+/// Equivalent to the kernel's [`pr_cont`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_cont`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_cont
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_info!("hello");
+/// pr_cont!(" {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_cont (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::CONT, true, $($arg)*)
+    )
+);
diff --git a/rust/kernel/random.rs b/rust/kernel/random.rs
new file mode 100644
index 000000000000..a7df79c1f7bf
--- /dev/null
+++ b/rust/kernel/random.rs
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Random numbers.
+//!
+//! C header: [`include/linux/random.h`](../../../../include/linux/random.h)
+
+use core::convert::TryInto;
+
+use crate::{bindings, c_types, error};
+
+/// Fills a byte slice with random bytes generated from the kernel's CSPRNG.
+///
+/// Ensures that the CSPRNG has been seeded before generating any random bytes,
+/// and will block until it is ready.
+pub fn getrandom(dest: &mut [u8]) -> error::KernelResult {
+    let res = unsafe { bindings::wait_for_random_bytes() };
+    if res != 0 {
+        return Err(error::Error::from_kernel_errno(res));
+    }
+
+    unsafe {
+        bindings::get_random_bytes(
+            dest.as_mut_ptr() as *mut c_types::c_void,
+            dest.len().try_into()?,
+        );
+    }
+    Ok(())
+}
+
+/// Fills a byte slice with random bytes generated from the kernel's CSPRNG.
+///
+/// If the CSPRNG is not yet seeded, returns an `Err(EAGAIN)` immediately.
+pub fn getrandom_nonblock(dest: &mut [u8]) -> error::KernelResult {
+    if !unsafe { bindings::rng_is_initialized() } {
+        return Err(error::Error::EAGAIN);
+    }
+    getrandom(dest)
+}
+
+/// Contributes the contents of a byte slice to the kernel's entropy pool.
+///
+/// Does *not* credit the kernel entropy counter though.
+pub fn add_randomness(data: &[u8]) {
+    unsafe {
+        bindings::add_device_randomness(
+            data.as_ptr() as *const c_types::c_void,
+            data.len().try_into().unwrap(),
+        );
+    }
+}
diff --git a/rust/kernel/static_assert.rs b/rust/kernel/static_assert.rs
new file mode 100644
index 000000000000..1d8f137155c6
--- /dev/null
+++ b/rust/kernel/static_assert.rs
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Static assert.
+
+/// Static assert (i.e. compile-time assert).
+///
+/// Similar to C11 [`_Static_assert`] and C++11 [`static_assert`].
+///
+/// The feature may be added to Rust in the future: see [RFC 2790].
+///
+/// [`_Static_assert`]: https://en.cppreference.com/w/c/language/_Static_assert
+/// [`static_assert`]: https://en.cppreference.com/w/cpp/language/static_assert
+/// [RFC 2790]: https://github.com/rust-lang/rfcs/issues/2790
+///
+/// # Examples
+///
+/// ```
+/// static_assert!(42 > 24);
+/// static_assert!(core::mem::size_of::<u8>() == 1);
+///
+/// const X: &[u8] = b"bar";
+/// static_assert!(X[1] == 'a' as u8);
+///
+/// const fn f(x: i32) -> i32 {
+///     x + 2
+/// }
+/// static_assert!(f(40) == 42);
+/// ```
+#[macro_export]
+macro_rules! static_assert {
+    ($condition:expr) => {
+        // Based on the latest one in `rustc`'s one before it was [removed].
+        //
+        // [removed]: https://github.com/rust-lang/rust/commit/c2dad1c6b9f9636198d7c561b47a2974f5103f6d
+        #[allow(dead_code)]
+        const _: () = [()][!($condition) as usize];
+    };
+}
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
new file mode 100644
index 000000000000..9b3ae4951443
--- /dev/null
+++ b/rust/kernel/sync/arc.rs
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A reference-counted pointer.
+//!
+//! This module implements a way for users to create reference-counted objects and pointers to
+//! them. Such a pointer automatically increments and decrements the count, and drops the
+//! underlying object when it reaches zero. It is also safe to use concurrently from multiple
+//! threads.
+//!
+//! It is different from the standard library's [`Arc`] in two ways: it does not support weak
+//! references, which allows it to be smaller -- a single pointer-sized integer; it allows users to
+//! safely increment the reference count from a single reference to the underlying object.
+//!
+//! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
+
+use crate::KernelResult;
+use alloc::boxed::Box;
+use core::{
+    mem::ManuallyDrop,
+    ops::Deref,
+    ptr::NonNull,
+    sync::atomic::{fence, AtomicUsize, Ordering},
+};
+
+/// A reference-counted pointer to an instance of `T`.
+///
+/// The reference count is incremented when new instances of [`Ref`] are created, and decremented
+/// when they are dropped. When the count reaches zero, the underlying `T` is also dropped.
+///
+/// # Invariants
+///
+/// The value stored in [`RefCounted::get_count`] corresponds to the number of instances of [`Ref`]
+/// that point to that instance of `T`.
+pub struct Ref<T: RefCounted + ?Sized> {
+    ptr: NonNull<T>,
+}
+
+// SAFETY: It is safe to send `Ref<T>` to another thread when the underlying `T` is `Sync` because
+// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
+// `T` to be `Send` because any thread that has a `Ref<T>` may ultimately access `T` directly, for
+// example, when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: RefCounted + ?Sized + Sync + Send> Send for Ref<T> {}
+
+// SAFETY: It is safe to send `&Ref<T>` to another thread when the underlying `T` is `Sync` for
+// the same reason as above. `T` needs to be `Send` as well because a thread can clone a `&Ref<T>`
+// into a `Ref<T>`, which may lead to `T` being accessed by the same reasoning as above.
+unsafe impl<T: RefCounted + ?Sized + Sync + Send> Sync for Ref<T> {}
+
+impl<T: RefCounted> Ref<T> {
+    /// Constructs a new reference counted instance of `T`.
+    pub fn try_new(contents: T) -> KernelResult<Self> {
+        let boxed = Box::try_new(contents)?;
+        boxed.get_count().count.store(1, Ordering::Relaxed);
+        let ptr = NonNull::from(Box::leak(boxed));
+        Ok(Ref { ptr })
+    }
+}
+
+impl<T: RefCounted + ?Sized> Ref<T> {
+    /// Creates a new reference-counted pointer to the given instance of `T`.
+    ///
+    /// It works by incrementing the current reference count as part of constructing the new
+    /// pointer.
+    pub fn new_from(obj: &T) -> Self {
+        let ref_count = obj.get_count();
+        let cur = ref_count.count.fetch_add(1, Ordering::Relaxed);
+        if cur == usize::MAX {
+            panic!("Reference count overflowed");
+        }
+        Self {
+            ptr: NonNull::from(obj),
+        }
+    }
+
+    /// Returns a mutable reference to `T` iff the reference count is one. Otherwise returns
+    /// [`None`].
+    pub fn get_mut(&mut self) -> Option<&mut T> {
+        // Synchronises with the decrement in `drop`.
+        if self.get_count().count.load(Ordering::Acquire) != 1 {
+            return None;
+        }
+        // SAFETY: Since there is only one reference, we know it isn't possible for another thread
+        // to concurrently call this.
+        Some(unsafe { self.ptr.as_mut() })
+    }
+
+    /// Determines if two reference-counted pointers point to the same underlying instance of `T`.
+    pub fn ptr_eq(a: &Self, b: &Self) -> bool {
+        core::ptr::eq(a.ptr.as_ptr(), b.ptr.as_ptr())
+    }
+
+    /// Deconstructs a [`Ref`] object into a raw pointer.
+    ///
+    /// It can be reconstructed once via [`Ref::from_raw`].
+    pub fn into_raw(obj: Self) -> *const T {
+        let no_drop = ManuallyDrop::new(obj);
+        no_drop.ptr.as_ptr()
+    }
+
+    /// Recreates a [`Ref`] instance previously deconstructed via [`Ref::into_raw`].
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must have been returned by a previous call to [`Ref::into_raw`]. Additionally, it
+    /// can only be called once for each previous call to [``Ref::into_raw`].
+    pub unsafe fn from_raw(ptr: *const T) -> Self {
+        Ref {
+            ptr: NonNull::new(ptr as _).unwrap(),
+        }
+    }
+}
+
+impl<T: RefCounted + ?Sized> Deref for Ref<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to dereference it.
+        unsafe { self.ptr.as_ref() }
+    }
+}
+
+impl<T: RefCounted + ?Sized> Clone for Ref<T> {
+    fn clone(&self) -> Self {
+        Self::new_from(self)
+    }
+}
+
+impl<T: RefCounted + ?Sized> Drop for Ref<T> {
+    fn drop(&mut self) {
+        {
+            // SAFETY: By the type invariant, there is necessarily a reference to the object.
+            let obj = unsafe { self.ptr.as_ref() };
+
+            // Synchronises with the acquire below or with the acquire in `get_mut`.
+            if obj.get_count().count.fetch_sub(1, Ordering::Release) != 1 {
+                return;
+            }
+        }
+
+        // Synchronises with the release when decrementing above. This ensures that modifications
+        // from all previous threads/CPUs are visible to the underlying object's `drop`.
+        fence(Ordering::Acquire);
+
+        // The count reached zero, we must free the memory.
+        //
+        // SAFETY: The pointer was initialised from the result of `Box::into_raw`.
+        unsafe { Box::from_raw(self.ptr.as_ptr()) };
+    }
+}
+
+/// Trait for reference counted objects.
+///
+/// # Safety
+///
+/// Implementers of [`RefCounted`] must ensure that all of their constructors call
+/// [`Ref::try_new`].
+pub unsafe trait RefCounted {
+    /// Returns a pointer to the object field holds the reference count.
+    fn get_count(&self) -> &RefCount;
+}
+
+/// Holds the reference count of an object.
+///
+/// It is meant to be embedded in objects to be reference-counted, with [`RefCounted::get_count`]
+/// returning a reference to it.
+pub struct RefCount {
+    count: AtomicUsize,
+}
+
+impl RefCount {
+    /// Constructs a new instance of [`RefCount`].
+    pub fn new() -> Self {
+        Self {
+            count: AtomicUsize::new(1),
+        }
+    }
+}
+
+impl Default for RefCount {
+    fn default() -> Self {
+        Self::new()
+    }
+}
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
new file mode 100644
index 000000000000..6d57fb1daea4
--- /dev/null
+++ b/rust/kernel/sync/condvar.rs
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A condition variable.
+//!
+//! This module allows Rust code to use the kernel's [`struct wait_queue_head`] as a condition
+//! variable.
+
+use super::{Guard, Lock, NeedsLockClass};
+use crate::{bindings, c_types, CStr};
+use core::{cell::UnsafeCell, marker::PhantomPinned, mem::MaybeUninit, pin::Pin};
+
+extern "C" {
+    fn rust_helper_init_wait(wq: *mut bindings::wait_queue_entry);
+    fn rust_helper_signal_pending() -> c_types::c_int;
+}
+
+/// Safely initialises a [`CondVar`] with the given name, generating a new lock class.
+#[macro_export]
+macro_rules! condvar_init {
+    ($condvar:expr, $name:literal) => {
+        $crate::init_with_lockdep!($condvar, $name)
+    };
+}
+
+// TODO: `bindgen` is not generating this constant. Figure out why.
+const POLLFREE: u32 = 0x4000;
+
+/// Exposes the kernel's [`struct wait_queue_head`] as a condition variable. It allows the caller to
+/// atomically release the given lock and go to sleep. It reacquires the lock when it wakes up. And
+/// it wakes up when notified by another thread (via [`CondVar::notify_one`] or
+/// [`CondVar::notify_all`]) or because the thread received a signal.
+///
+/// [`struct wait_queue_head`]: ../../../include/linux/wait.h
+pub struct CondVar {
+    pub(crate) wait_list: UnsafeCell<bindings::wait_queue_head>,
+
+    /// A condvar needs to be pinned because it contains a [`struct list_head`] that is
+    /// self-referential, so it cannot be safely moved once it is initialised.
+    _pin: PhantomPinned,
+}
+
+// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on any thread.
+unsafe impl Send for CondVar {}
+
+// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on multiple threads
+// concurrently.
+unsafe impl Sync for CondVar {}
+
+impl CondVar {
+    /// Constructs a new conditional variable.
+    ///
+    /// # Safety
+    ///
+    /// The caller must call `CondVar::init` before using the conditional variable.
+    pub unsafe fn new() -> Self {
+        Self {
+            wait_list: UnsafeCell::new(bindings::wait_queue_head::default()),
+            _pin: PhantomPinned,
+        }
+    }
+
+    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
+    /// thread to sleep. It wakes up when notified by [`CondVar::notify_one`] or
+    /// [`CondVar::notify_all`], or when the thread receives a signal.
+    ///
+    /// Returns whether there is a signal pending.
+    #[must_use = "wait returns if a signal is pending, so the caller must check the return value"]
+    pub fn wait<L: Lock>(&self, guard: &mut Guard<L>) -> bool {
+        let lock = guard.lock;
+        let mut wait = MaybeUninit::<bindings::wait_queue_entry>::uninit();
+
+        // SAFETY: `wait` points to valid memory.
+        unsafe { rust_helper_init_wait(wait.as_mut_ptr()) };
+
+        // SAFETY: Both `wait` and `wait_list` point to valid memory.
+        unsafe {
+            bindings::prepare_to_wait_exclusive(
+                self.wait_list.get(),
+                wait.as_mut_ptr(),
+                bindings::TASK_INTERRUPTIBLE as _,
+            );
+        }
+
+        // SAFETY: The guard is evidence that the caller owns the lock.
+        unsafe { lock.unlock() };
+
+        // SAFETY: No arguments, switches to another thread.
+        unsafe { bindings::schedule() };
+
+        lock.lock_noguard();
+
+        // SAFETY: Both `wait` and `wait_list` point to valid memory.
+        unsafe { bindings::finish_wait(self.wait_list.get(), wait.as_mut_ptr()) };
+
+        // SAFETY: No arguments, just checks `current` for pending signals.
+        unsafe { rust_helper_signal_pending() != 0 }
+    }
+
+    /// Calls the kernel function to notify the appropriate number of threads with the given flags.
+    fn notify(&self, count: i32, flags: u32) {
+        // SAFETY: `wait_list` points to valid memory.
+        unsafe {
+            bindings::__wake_up(
+                self.wait_list.get(),
+                bindings::TASK_NORMAL,
+                count,
+                flags as _,
+            )
+        };
+    }
+
+    /// Wakes a single waiter up, if any. This is not 'sticky' in the sense that if no thread is
+    /// waiting, the notification is lost completely (as opposed to automatically waking up the
+    /// next waiter).
+    pub fn notify_one(&self) {
+        self.notify(1, 0);
+    }
+
+    /// Wakes all waiters up, if any. This is not 'sticky' in the sense that if no thread is
+    /// waiting, the notification is lost completely (as opposed to automatically waking up the
+    /// next waiter).
+    pub fn notify_all(&self) {
+        self.notify(0, 0);
+    }
+
+    /// Wakes all waiters up. If they were added by `epoll`, they are also removed from the list of
+    /// waiters. This is useful when cleaning up a condition variable that may be waited on by
+    /// threads that use `epoll`.
+    pub fn free_waiters(&self) {
+        self.notify(1, bindings::POLLHUP | POLLFREE);
+    }
+}
+
+impl NeedsLockClass for CondVar {
+    unsafe fn init(self: Pin<&Self>, name: CStr<'static>, key: *mut bindings::lock_class_key) {
+        bindings::__init_waitqueue_head(self.wait_list.get(), name.as_ptr() as _, key);
+    }
+}
diff --git a/rust/kernel/sync/guard.rs b/rust/kernel/sync/guard.rs
new file mode 100644
index 000000000000..84e5d319a5fd
--- /dev/null
+++ b/rust/kernel/sync/guard.rs
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A generic lock guard and trait.
+//!
+//! This module contains a lock guard that can be used with any locking primitive that implements
+//! the ([`Lock`]) trait. It also contains the definition of the trait, which can be leveraged by
+//! other constructs to work on generic locking primitives.
+
+/// Allows mutual exclusion primitives that implement the [`Lock`] trait to automatically unlock
+/// when a guard goes out of scope. It also provides a safe and convenient way to access the data
+/// protected by the lock.
+#[must_use = "the lock unlocks immediately when the guard is unused"]
+pub struct Guard<'a, L: Lock + ?Sized> {
+    pub(crate) lock: &'a L,
+}
+
+// SAFETY: `Guard` is sync when the data protected by the lock is also sync. This is more
+// conservative than the default compiler implementation; more details can be found on
+// https://github.com/rust-lang/rust/issues/41622 -- it refers to `MutexGuard` from the standard
+// library.
+unsafe impl<L> Sync for Guard<'_, L>
+where
+    L: Lock + ?Sized,
+    L::Inner: Sync,
+{
+}
+
+impl<L: Lock + ?Sized> core::ops::Deref for Guard<'_, L> {
+    type Target = L::Inner;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
+        unsafe { &*self.lock.locked_data().get() }
+    }
+}
+
+impl<L: Lock + ?Sized> core::ops::DerefMut for Guard<'_, L> {
+    fn deref_mut(&mut self) -> &mut L::Inner {
+        // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
+        unsafe { &mut *self.lock.locked_data().get() }
+    }
+}
+
+impl<L: Lock + ?Sized> Drop for Guard<'_, L> {
+    fn drop(&mut self) {
+        // SAFETY: The caller owns the lock, so it is safe to unlock it.
+        unsafe { self.lock.unlock() };
+    }
+}
+
+impl<'a, L: Lock + ?Sized> Guard<'a, L> {
+    /// Constructs a new lock guard.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that it owns the lock.
+    pub(crate) unsafe fn new(lock: &'a L) -> Self {
+        Self { lock }
+    }
+}
+
+/// A generic mutual exclusion primitive.
+///
+/// [`Guard`] is written such that any mutual exclusion primitive that can implement this trait can
+/// also benefit from having an automatic way to unlock itself.
+pub trait Lock {
+    /// The type of the data protected by the lock.
+    type Inner: ?Sized;
+
+    /// Acquires the lock, making the caller its owner.
+    fn lock_noguard(&self);
+
+    /// Releases the lock, giving up ownership of the lock.
+    ///
+    /// # Safety
+    ///
+    /// It must only be called by the current owner of the lock.
+    unsafe fn unlock(&self);
+
+    /// Returns the data protected by the lock.
+    fn locked_data(&self) -> &core::cell::UnsafeCell<Self::Inner>;
+}
diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
new file mode 100644
index 000000000000..fc540b35c53a
--- /dev/null
+++ b/rust/kernel/sync/locked_by.rs
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A wrapper for data protected by a lock that does not wrap it.
+
+use super::{Guard, Lock};
+use core::{cell::UnsafeCell, ops::Deref, ptr};
+
+/// Allows access to some data to be serialised by a lock that does not wrap it.
+///
+/// In most cases, data protected by a lock is wrapped by the appropriate lock type, e.g.,
+/// [`super::Mutex`] or [`super::SpinLock`]. [`LockedBy`] is meant for cases when this is not
+/// possible. For example, if a container has a lock and some data in the contained elements needs
+/// to be protected by the same lock.
+///
+/// [`LockedBy`] wraps the data in lieu of another locking primitive, and only allows access to it
+/// when the caller shows evidence that 'external' lock is locked.
+///
+/// # Example
+///
+/// The following is an example for illustrative purposes: `InnerDirectory::bytes_used` is an
+/// aggregate of all `InnerFile::bytes_used` and must be kept consistent; so we wrap `InnerFile` in
+/// a `LockedBy` so that it shares a lock with `InnerDirectory`. This allows us to enforce at
+/// compile-time that access to `InnerFile` is only granted when an `InnerDirectory` is also
+/// locked; we enforce at run time that the right `InnerDirectory` is locked.
+///
+/// ```
+/// use super::Mutex;
+/// use alloc::{string::String, vec::Vec};
+///
+/// struct InnerFile {
+///     bytes_used: u64,
+/// }
+///
+/// struct File {
+///     name: String,
+///     inner: LockedBy<InnerFile, Mutex<InnerDirectory>>,
+/// }
+///
+/// struct InnerDirectory {
+///     /// The sum of the bytes used by all files.
+///     bytes_used: u64,
+///     files: Vec<File>,
+/// }
+///
+/// struct Directory {
+///     name: String,
+///     inner: Mutex<InnerDirectory>,
+/// }
+/// ```
+pub struct LockedBy<T: ?Sized, L: Lock + ?Sized> {
+    owner: *const L::Inner,
+    data: UnsafeCell<T>,
+}
+
+// SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it protects can.
+unsafe impl<T: ?Sized + Send, L: Lock + ?Sized> Send for LockedBy<T, L> {}
+
+// SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
+// data it protects is `Send`.
+unsafe impl<T: ?Sized + Send, L: Lock + ?Sized> Sync for LockedBy<T, L> {}
+
+impl<T, L: Lock + ?Sized> LockedBy<T, L> {
+    /// Constructs a new instance of [`LockedBy`].
+    ///
+    /// It stores a raw pointer to the owner that is never dereferenced. It is only used to ensure
+    /// that the right owner is being used to access the protected data. If the owner is freed, the
+    /// data becomes inaccessible; if another instance of the owner is allocated *on the same
+    /// memory location*, the data becomes accessible again: none of this affects memory safety
+    /// because in any case at most one thread (or CPU) can access the protected data at a time.
+    pub fn new(owner: &L, data: T) -> Self {
+        Self {
+            owner: owner.locked_data().get(),
+            data: UnsafeCell::new(data),
+        }
+    }
+}
+
+impl<T: ?Sized, L: Lock + ?Sized> LockedBy<T, L> {
+    /// Returns a reference to the protected data when the caller provides evidence (via a
+    /// [`Guard`]) that the owner is locked.
+    pub fn access<'a>(&'a self, guard: &'a Guard<L>) -> &'a T {
+        if !ptr::eq(guard.deref(), self.owner) {
+            panic!("guard does not match owner");
+        }
+
+        // SAFETY: `guard` is evidence that the owner is locked.
+        unsafe { &mut *self.data.get() }
+    }
+
+    /// Returns a mutable reference to the protected data when the caller provides evidence (via a
+    /// mutable [`Guard`]) that the owner is locked mutably.
+    pub fn access_mut<'a>(&'a self, guard: &'a mut Guard<L>) -> &'a mut T {
+        if !ptr::eq(guard.deref().deref(), self.owner) {
+            panic!("guard does not match owner");
+        }
+
+        // SAFETY: `guard` is evidence that the owner is locked.
+        unsafe { &mut *self.data.get() }
+    }
+
+    /// Returns a mutable reference to the protected data when the caller provides evidence (via a
+    /// mutable owner) that the owner is locked mutably. Showing a mutable reference to the owner
+    /// is sufficient because we know no other references can exist to it.
+    pub fn access_from_mut<'a>(&'a self, owner: &'a mut L::Inner) -> &'a mut T {
+        if !ptr::eq(owner, self.owner) {
+            panic!("mismatched owners");
+        }
+
+        // SAFETY: `owner` is evidence that there is only one reference to the owner.
+        unsafe { &mut *self.data.get() }
+    }
+}
diff --git a/rust/kernel/sync/mod.rs b/rust/kernel/sync/mod.rs
new file mode 100644
index 000000000000..25f5109429a8
--- /dev/null
+++ b/rust/kernel/sync/mod.rs
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Synchronisation primitives.
+//!
+//! This module contains the kernel APIs related to synchronisation that have been ported or
+//! wrapped for usage by Rust code in the kernel and is shared by all of them.
+//!
+//! # Example
+//!
+//! ```
+//! fn test() {
+//!     // SAFETY: `init` is called below.
+//!     let data = alloc::sync::Arc::pin(unsafe { Mutex::new(0) });
+//!     mutex_init!(data.as_ref(), "test::data");
+//!     *data.lock() = 10;
+//!     pr_info!("{}\n", *data.lock());
+//! }
+//! ```
+
+use crate::{bindings, CStr};
+use core::pin::Pin;
+
+mod arc;
+mod condvar;
+mod guard;
+mod locked_by;
+mod mutex;
+mod spinlock;
+
+pub use arc::{Ref, RefCount, RefCounted};
+pub use condvar::CondVar;
+pub use guard::{Guard, Lock};
+pub use locked_by::LockedBy;
+pub use mutex::Mutex;
+pub use spinlock::SpinLock;
+
+/// Safely initialises an object that has an `init` function that takes a name and a lock class as
+/// arguments, examples of these are [`Mutex`] and [`SpinLock`]. Each of them also provides a more
+/// specialised name that uses this macro.
+#[doc(hidden)]
+#[macro_export]
+macro_rules! init_with_lockdep {
+    ($obj:expr, $name:literal) => {{
+        static mut CLASS: core::mem::MaybeUninit<$crate::bindings::lock_class_key> =
+            core::mem::MaybeUninit::uninit();
+        // SAFETY: `CLASS` is never used by Rust code directly; the kernel may change it though.
+        #[allow(unused_unsafe)]
+        unsafe {
+            $crate::sync::NeedsLockClass::init($obj, $crate::cstr!($name), CLASS.as_mut_ptr())
+        };
+    }};
+}
+
+/// A trait for types that need a lock class during initialisation.
+///
+/// Implementers of this trait benefit from the [`init_with_lockdep`] macro that generates a new
+/// class for each initialisation call site.
+pub trait NeedsLockClass {
+    /// Initialises the type instance so that it can be safely used.
+    ///
+    /// Callers are encouraged to use the [`init_with_lockdep`] macro as it automatically creates a
+    /// new lock class on each usage.
+    ///
+    /// # Safety
+    ///
+    /// `key` must point to a valid memory location as it will be used by the kernel.
+    unsafe fn init(self: Pin<&Self>, name: CStr<'static>, key: *mut bindings::lock_class_key);
+}
diff --git a/rust/kernel/sync/mutex.rs b/rust/kernel/sync/mutex.rs
new file mode 100644
index 000000000000..e528228d16c1
--- /dev/null
+++ b/rust/kernel/sync/mutex.rs
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A kernel mutex.
+//!
+//! This module allows Rust code to use the kernel's [`struct mutex`].
+
+use super::{Guard, Lock, NeedsLockClass};
+use crate::{bindings, CStr};
+use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
+
+/// Safely initialises a [`Mutex`] with the given name, generating a new lock class.
+#[macro_export]
+macro_rules! mutex_init {
+    ($mutex:expr, $name:literal) => {
+        $crate::init_with_lockdep!($mutex, $name)
+    };
+}
+
+/// Exposes the kernel's [`struct mutex`]. When multiple threads attempt to lock the same mutex,
+/// only one at a time is allowed to progress, the others will block (sleep) until the mutex is
+/// unlocked, at which point another thread will be allowed to wake up and make progress.
+///
+/// A [`Mutex`] must first be initialised with a call to [`Mutex::init`] before it can be used. The
+/// [`mutex_init`] macro is provided to automatically assign a new lock class to a mutex instance.
+///
+/// Since it may block, [`Mutex`] needs to be used with care in atomic contexts.
+///
+/// [`struct mutex`]: ../../../include/linux/mutex.h
+pub struct Mutex<T: ?Sized> {
+    /// The kernel `struct mutex` object.
+    mutex: UnsafeCell<bindings::mutex>,
+
+    /// A mutex needs to be pinned because it contains a [`struct list_head`] that is
+    /// self-referential, so it cannot be safely moved once it is initialised.
+    _pin: PhantomPinned,
+
+    /// The data protected by the mutex.
+    data: UnsafeCell<T>,
+}
+
+// SAFETY: `Mutex` can be transferred across thread boundaries iff the data it protects can.
+unsafe impl<T: ?Sized + Send> Send for Mutex<T> {}
+
+// SAFETY: `Mutex` serialises the interior mutability it provides, so it is `Sync` as long as the
+// data it protects is `Send`.
+unsafe impl<T: ?Sized + Send> Sync for Mutex<T> {}
+
+impl<T> Mutex<T> {
+    /// Constructs a new mutex.
+    ///
+    /// # Safety
+    ///
+    /// The caller must call [`Mutex::init`] before using the mutex.
+    pub unsafe fn new(t: T) -> Self {
+        Self {
+            mutex: UnsafeCell::new(bindings::mutex::default()),
+            data: UnsafeCell::new(t),
+            _pin: PhantomPinned,
+        }
+    }
+}
+
+impl<T: ?Sized> Mutex<T> {
+    /// Locks the mutex and gives the caller access to the data protected by it. Only one thread at
+    /// a time is allowed to access the protected data.
+    pub fn lock(&self) -> Guard<Self> {
+        self.lock_noguard();
+        // SAFETY: The mutex was just acquired.
+        unsafe { Guard::new(self) }
+    }
+}
+
+impl<T: ?Sized> NeedsLockClass for Mutex<T> {
+    unsafe fn init(self: Pin<&Self>, name: CStr<'static>, key: *mut bindings::lock_class_key) {
+        bindings::__mutex_init(self.mutex.get(), name.as_ptr() as _, key);
+    }
+}
+
+impl<T: ?Sized> Lock for Mutex<T> {
+    type Inner = T;
+
+    #[cfg(not(CONFIG_DEBUG_LOCK_ALLOC))]
+    fn lock_noguard(&self) {
+        // SAFETY: `mutex` points to valid memory.
+        unsafe { bindings::mutex_lock(self.mutex.get()) };
+    }
+
+    #[cfg(CONFIG_DEBUG_LOCK_ALLOC)]
+    fn lock_noguard(&self) {
+        // SAFETY: `mutex` points to valid memory.
+        unsafe { bindings::mutex_lock_nested(self.mutex.get(), 0) };
+    }
+
+    unsafe fn unlock(&self) {
+        bindings::mutex_unlock(self.mutex.get());
+    }
+
+    fn locked_data(&self) -> &UnsafeCell<T> {
+        &self.data
+    }
+}
diff --git a/rust/kernel/sync/spinlock.rs b/rust/kernel/sync/spinlock.rs
new file mode 100644
index 000000000000..49a7d5fd837b
--- /dev/null
+++ b/rust/kernel/sync/spinlock.rs
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A kernel spinlock.
+//!
+//! This module allows Rust code to use the kernel's [`struct spinlock`].
+//!
+//! See <https://www.kernel.org/doc/Documentation/locking/spinlocks.txt>.
+
+use super::{Guard, Lock, NeedsLockClass};
+use crate::{bindings, c_types, CStr};
+use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
+
+extern "C" {
+    #[allow(improper_ctypes)]
+    fn rust_helper_spin_lock_init(
+        lock: *mut bindings::spinlock_t,
+        name: *const c_types::c_char,
+        key: *mut bindings::lock_class_key,
+    );
+    fn rust_helper_spin_lock(lock: *mut bindings::spinlock);
+    fn rust_helper_spin_unlock(lock: *mut bindings::spinlock);
+}
+
+/// Safely initialises a [`SpinLock`] with the given name, generating a new lock class.
+#[macro_export]
+macro_rules! spinlock_init {
+    ($spinlock:expr, $name:literal) => {
+        $crate::init_with_lockdep!($spinlock, $name)
+    };
+}
+
+/// Exposes the kernel's [`spinlock_t`]. When multiple CPUs attempt to lock the same spinlock, only
+/// one at a time is allowed to progress, the others will block (spinning) until the spinlock is
+/// unlocked, at which point another CPU will be allowed to make progress.
+///
+/// A [`SpinLock`] must first be initialised with a call to [`SpinLock::init`] before it can be
+/// used. The [`spinlock_init`] macro is provided to automatically assign a new lock class to a
+/// spinlock instance.
+///
+/// [`SpinLock`] does not manage the interrupt state, so it can be used in only two cases: (a) when
+/// the caller knows that interrupts are disabled, or (b) when callers never use it in interrupt
+/// handlers (in which case it is ok for interrupts to be enabled).
+///
+/// [`spinlock_t`]: ../../../include/linux/spinlock.h
+pub struct SpinLock<T: ?Sized> {
+    spin_lock: UnsafeCell<bindings::spinlock>,
+
+    /// Spinlocks are architecture-defined. So we conservatively require them to be pinned in case
+    /// some architecture uses self-references now or in the future.
+    _pin: PhantomPinned,
+
+    data: UnsafeCell<T>,
+}
+
+// SAFETY: `SpinLock` can be transferred across thread boundaries iff the data it protects can.
+unsafe impl<T: ?Sized + Send> Send for SpinLock<T> {}
+
+// SAFETY: `SpinLock` serialises the interior mutability it provides, so it is `Sync` as long as the
+// data it protects is `Send`.
+unsafe impl<T: ?Sized + Send> Sync for SpinLock<T> {}
+
+impl<T> SpinLock<T> {
+    /// Constructs a new spinlock.
+    ///
+    /// # Safety
+    ///
+    /// The caller must call [`SpinLock::init`] before using the spinlock.
+    pub unsafe fn new(t: T) -> Self {
+        Self {
+            spin_lock: UnsafeCell::new(bindings::spinlock::default()),
+            data: UnsafeCell::new(t),
+            _pin: PhantomPinned,
+        }
+    }
+}
+
+impl<T: ?Sized> SpinLock<T> {
+    /// Locks the spinlock and gives the caller access to the data protected by it. Only one thread
+    /// at a time is allowed to access the protected data.
+    pub fn lock(&self) -> Guard<Self> {
+        self.lock_noguard();
+        // SAFETY: The spinlock was just acquired.
+        unsafe { Guard::new(self) }
+    }
+}
+
+impl<T: ?Sized> NeedsLockClass for SpinLock<T> {
+    unsafe fn init(self: Pin<&Self>, name: CStr<'static>, key: *mut bindings::lock_class_key) {
+        rust_helper_spin_lock_init(self.spin_lock.get(), name.as_ptr() as _, key);
+    }
+}
+
+impl<T: ?Sized> Lock for SpinLock<T> {
+    type Inner = T;
+
+    fn lock_noguard(&self) {
+        // SAFETY: `spin_lock` points to valid memory.
+        unsafe { rust_helper_spin_lock(self.spin_lock.get()) };
+    }
+
+    unsafe fn unlock(&self) {
+        rust_helper_spin_unlock(self.spin_lock.get());
+    }
+
+    fn locked_data(&self) -> &UnsafeCell<T> {
+        &self.data
+    }
+}
diff --git a/rust/kernel/sysctl.rs b/rust/kernel/sysctl.rs
new file mode 100644
index 000000000000..a1928a8523db
--- /dev/null
+++ b/rust/kernel/sysctl.rs
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! System control.
+//!
+//! C header: [`include/linux/sysctl.h`](../../../../include/linux/sysctl.h)
+//!
+//! Reference: <https://www.kernel.org/doc/Documentation/sysctl/README>
+
+use alloc::boxed::Box;
+use alloc::vec;
+use core::mem;
+use core::ptr;
+use core::sync::atomic;
+
+use crate::bindings;
+use crate::c_types;
+use crate::error;
+use crate::types;
+use crate::user_ptr::{UserSlicePtr, UserSlicePtrWriter};
+
+/// Sysctl storage.
+pub trait SysctlStorage: Sync {
+    /// Writes a byte slice.
+    fn store_value(&self, data: &[u8]) -> (usize, error::KernelResult);
+
+    /// Reads via a [`UserSlicePtrWriter`].
+    fn read_value(&self, data: &mut UserSlicePtrWriter) -> (usize, error::KernelResult);
+}
+
+fn trim_whitespace(mut data: &[u8]) -> &[u8] {
+    while !data.is_empty() && (data[0] == b' ' || data[0] == b'\t' || data[0] == b'\n') {
+        data = &data[1..];
+    }
+    while !data.is_empty()
+        && (data[data.len() - 1] == b' '
+            || data[data.len() - 1] == b'\t'
+            || data[data.len() - 1] == b'\n')
+    {
+        data = &data[..data.len() - 1];
+    }
+    data
+}
+
+impl<T> SysctlStorage for &T
+where
+    T: SysctlStorage,
+{
+    fn store_value(&self, data: &[u8]) -> (usize, error::KernelResult) {
+        (*self).store_value(data)
+    }
+
+    fn read_value(&self, data: &mut UserSlicePtrWriter) -> (usize, error::KernelResult) {
+        (*self).read_value(data)
+    }
+}
+
+impl SysctlStorage for atomic::AtomicBool {
+    fn store_value(&self, data: &[u8]) -> (usize, error::KernelResult) {
+        let result = match trim_whitespace(data) {
+            b"0" => {
+                self.store(false, atomic::Ordering::Relaxed);
+                Ok(())
+            }
+            b"1" => {
+                self.store(true, atomic::Ordering::Relaxed);
+                Ok(())
+            }
+            _ => Err(error::Error::EINVAL),
+        };
+        (data.len(), result)
+    }
+
+    fn read_value(&self, data: &mut UserSlicePtrWriter) -> (usize, error::KernelResult) {
+        let value = if self.load(atomic::Ordering::Relaxed) {
+            b"1\n"
+        } else {
+            b"0\n"
+        };
+        (value.len(), data.write_slice(value))
+    }
+}
+
+/// Holds a single `sysctl` entry (and its table).
+pub struct Sysctl<T: SysctlStorage> {
+    inner: Box<T>,
+    // Responsible for keeping the `ctl_table` alive.
+    _table: Box<[bindings::ctl_table]>,
+    header: *mut bindings::ctl_table_header,
+}
+
+// SAFETY: The only public method we have is `get()`, which returns `&T`, and
+// `T: Sync`. Any new methods must adhere to this requirement.
+unsafe impl<T: SysctlStorage> Sync for Sysctl<T> {}
+
+unsafe extern "C" fn proc_handler<T: SysctlStorage>(
+    ctl: *mut bindings::ctl_table,
+    write: c_types::c_int,
+    buffer: *mut c_types::c_void,
+    len: *mut usize,
+    ppos: *mut bindings::loff_t,
+) -> c_types::c_int {
+    // If we are reading from some offset other than the beginning of the file,
+    // return an empty read to signal EOF.
+    if *ppos != 0 && write == 0 {
+        *len = 0;
+        return 0;
+    }
+
+    let data = UserSlicePtr::new(buffer, *len);
+    let storage = &*((*ctl).data as *const T);
+    let (bytes_processed, result) = if write != 0 {
+        let data = match data.read_all() {
+            Ok(r) => r,
+            Err(e) => return e.to_kernel_errno(),
+        };
+        storage.store_value(&data)
+    } else {
+        let mut writer = data.writer();
+        storage.read_value(&mut writer)
+    };
+    *len = bytes_processed;
+    *ppos += *len as bindings::loff_t;
+    match result {
+        Ok(()) => 0,
+        Err(e) => e.to_kernel_errno(),
+    }
+}
+
+impl<T: SysctlStorage> Sysctl<T> {
+    /// Registers a single entry in `sysctl`.
+    pub fn register(
+        path: types::CStr<'static>,
+        name: types::CStr<'static>,
+        storage: T,
+        mode: types::Mode,
+    ) -> error::KernelResult<Sysctl<T>> {
+        if name.contains('/') {
+            return Err(error::Error::EINVAL);
+        }
+
+        let storage = Box::try_new(storage)?;
+        let mut table = vec![
+            bindings::ctl_table {
+                procname: name.as_ptr() as *const i8,
+                mode: mode.as_int(),
+                data: &*storage as *const T as *mut c_types::c_void,
+                proc_handler: Some(proc_handler::<T>),
+
+                maxlen: 0,
+                child: ptr::null_mut(),
+                poll: ptr::null_mut(),
+                extra1: ptr::null_mut(),
+                extra2: ptr::null_mut(),
+            },
+            unsafe { mem::zeroed() },
+        ]
+        .into_boxed_slice();
+
+        let result =
+            unsafe { bindings::register_sysctl(path.as_ptr() as *const i8, table.as_mut_ptr()) };
+        if result.is_null() {
+            return Err(error::Error::ENOMEM);
+        }
+
+        Ok(Sysctl {
+            inner: storage,
+            _table: table,
+            header: result,
+        })
+    }
+
+    /// Gets the storage.
+    pub fn get(&self) -> &T {
+        &self.inner
+    }
+}
+
+impl<T: SysctlStorage> Drop for Sysctl<T> {
+    fn drop(&mut self) {
+        unsafe {
+            bindings::unregister_sysctl_table(self.header);
+        }
+        self.header = ptr::null_mut();
+    }
+}
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
new file mode 100644
index 000000000000..6207670c3290
--- /dev/null
+++ b/rust/kernel/types.rs
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel types.
+//!
+//! C header: [`include/linux/types.h`](../../../../include/linux/types.h)
+
+use core::ops::Deref;
+
+use crate::bindings;
+
+/// Permissions.
+///
+/// C header: [`include/uapi/linux/stat.h`](../../../../include/uapi/linux/stat.h)
+///
+/// C header: [`include/linux/stat.h`](../../../../include/linux/stat.h)
+pub struct Mode(bindings::umode_t);
+
+impl Mode {
+    /// Creates a [`Mode`] from an integer.
+    pub fn from_int(m: u16) -> Mode {
+        Mode(m)
+    }
+
+    /// Returns the mode as an integer.
+    pub fn as_int(&self) -> u16 {
+        self.0
+    }
+}
+
+/// A string that is guaranteed to have exactly one `NUL` byte, which is at the
+/// end.
+///
+/// Used for interoperability with kernel APIs that take C strings.
+#[repr(transparent)]
+pub struct CStr<'a>(&'a str);
+
+impl CStr<'_> {
+    /// Creates a [`CStr`] from a [`str`] without performing any additional
+    /// checks.
+    ///
+    /// # Safety
+    ///
+    /// `data` *must* end with a `NUL` byte, and should only have only a single
+    /// `NUL` byte (or the string will be truncated).
+    pub const unsafe fn new_unchecked(data: &str) -> CStr {
+        CStr(data)
+    }
+}
+
+impl Deref for CStr<'_> {
+    type Target = str;
+
+    fn deref(&self) -> &str {
+        self.0
+    }
+}
+
+/// Creates a new `CStr` from a string literal.
+///
+/// The string literal should not contain any `NUL` bytes.
+///
+/// # Examples
+///
+/// ```rust,no_run
+/// const MY_CSTR: CStr<'static> = cstr!("My awesome CStr!");
+/// ```
+#[macro_export]
+macro_rules! cstr {
+    ($str:expr) => {{
+        let s = concat!($str, "\x00");
+        unsafe { $crate::CStr::new_unchecked(s) }
+    }};
+}
diff --git a/rust/kernel/user_ptr.rs b/rust/kernel/user_ptr.rs
new file mode 100644
index 000000000000..d9304d269d06
--- /dev/null
+++ b/rust/kernel/user_ptr.rs
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! User pointers.
+//!
+//! C header: [`include/linux/uaccess.h`](../../../../include/linux/uaccess.h)
+
+use crate::{c_types, error::Error, KernelResult};
+use alloc::vec::Vec;
+use core::mem::{size_of, MaybeUninit};
+
+extern "C" {
+    fn rust_helper_copy_from_user(
+        to: *mut c_types::c_void,
+        from: *const c_types::c_void,
+        n: c_types::c_ulong,
+    ) -> c_types::c_ulong;
+
+    fn rust_helper_copy_to_user(
+        to: *mut c_types::c_void,
+        from: *const c_types::c_void,
+        n: c_types::c_ulong,
+    ) -> c_types::c_ulong;
+}
+
+/// Specifies that a type is safely readable from byte slices.
+///
+/// Not all types can be safely read from byte slices; examples from
+/// <https://doc.rust-lang.org/reference/behavior-considered-undefined.html> include `bool`
+/// that must be either `0` or `1`, and `char` that cannot be a surrogate or above `char::MAX`.
+///
+/// # Safety
+///
+/// Implementers must ensure that the type is made up only of types that can be safely read from
+/// arbitrary byte sequences (e.g., `u32`, `u64`, etc.).
+pub unsafe trait ReadableFromBytes {}
+
+// SAFETY: All bit patterns are acceptable values of the types below.
+unsafe impl ReadableFromBytes for u8 {}
+unsafe impl ReadableFromBytes for u16 {}
+unsafe impl ReadableFromBytes for u32 {}
+unsafe impl ReadableFromBytes for u64 {}
+unsafe impl ReadableFromBytes for usize {}
+unsafe impl ReadableFromBytes for i8 {}
+unsafe impl ReadableFromBytes for i16 {}
+unsafe impl ReadableFromBytes for i32 {}
+unsafe impl ReadableFromBytes for i64 {}
+unsafe impl ReadableFromBytes for isize {}
+
+/// Specifies that a type is safely writable to byte slices.
+///
+/// This means that we don't read undefined values (which leads to UB) in preparation for writing
+/// to the byte slice. It also ensures that no potentially sensitive information is leaked into the
+/// byte slices.
+///
+/// # Safety
+///
+/// A type must not include padding bytes and must be fully initialised to safely implement
+/// [`WritableToBytes`] (i.e., it doesn't contain [`MaybeUninit`] fields). A composition of
+/// writable types in a structure is not necessarily writable because it may result in padding
+/// bytes.
+pub unsafe trait WritableToBytes {}
+
+// SAFETY: Initialised instances of the following types have no uninitialised portions.
+unsafe impl WritableToBytes for u8 {}
+unsafe impl WritableToBytes for u16 {}
+unsafe impl WritableToBytes for u32 {}
+unsafe impl WritableToBytes for u64 {}
+unsafe impl WritableToBytes for usize {}
+unsafe impl WritableToBytes for i8 {}
+unsafe impl WritableToBytes for i16 {}
+unsafe impl WritableToBytes for i32 {}
+unsafe impl WritableToBytes for i64 {}
+unsafe impl WritableToBytes for isize {}
+
+/// A reference to an area in userspace memory, which can be either
+/// read-only or read-write.
+///
+/// All methods on this struct are safe: invalid pointers return
+/// `EFAULT`. Concurrent access, *including data races to/from userspace
+/// memory*, is permitted, because fundamentally another userspace
+/// thread/process could always be modifying memory at the same time
+/// (in the same way that userspace Rust's [`std::io`] permits data races
+/// with the contents of files on disk). In the presence of a race, the
+/// exact byte values read/written are unspecified but the operation is
+/// well-defined. Kernelspace code should validate its copy of data
+/// after completing a read, and not expect that multiple reads of the
+/// same address will return the same value.
+///
+/// All APIs enforce the invariant that a given byte of memory from userspace
+/// may only be read once. By preventing double-fetches we avoid TOCTOU
+/// vulnerabilities. This is accomplished by taking `self` by value to prevent
+/// obtaining multiple readers on a given [`UserSlicePtr`], and the readers
+/// only permitting forward reads.
+///
+/// Constructing a [`UserSlicePtr`] performs no checks on the provided
+/// address and length, it can safely be constructed inside a kernel thread
+/// with no current userspace process. Reads and writes wrap the kernel APIs
+/// `copy_from_user` and `copy_to_user`, which check the memory map of the
+/// current process and enforce that the address range is within the user
+/// range (no additional calls to `access_ok` are needed).
+///
+/// [`std::io`]: https://doc.rust-lang.org/std/io/index.html
+pub struct UserSlicePtr(*mut c_types::c_void, usize);
+
+impl UserSlicePtr {
+    /// Constructs a user slice from a raw pointer and a length in bytes.
+    ///
+    /// # Safety
+    ///
+    /// Callers must be careful to avoid time-of-check-time-of-use
+    /// (TOCTOU) issues. The simplest way is to create a single instance of
+    /// [`UserSlicePtr`] per user memory block as it reads each byte at
+    /// most once.
+    pub unsafe fn new(ptr: *mut c_types::c_void, length: usize) -> Self {
+        UserSlicePtr(ptr, length)
+    }
+
+    /// Reads the entirety of the user slice.
+    ///
+    /// Returns `EFAULT` if the address does not currently point to
+    /// mapped, readable memory.
+    pub fn read_all(self) -> KernelResult<Vec<u8>> {
+        self.reader().read_all()
+    }
+
+    /// Constructs a [`UserSlicePtrReader`].
+    pub fn reader(self) -> UserSlicePtrReader {
+        UserSlicePtrReader(self.0, self.1)
+    }
+
+    /// Writes the provided slice into the user slice.
+    ///
+    /// Returns `EFAULT` if the address does not currently point to
+    /// mapped, writable memory (in which case some data from before the
+    /// fault may be written), or `data` is larger than the user slice
+    /// (in which case no data is written).
+    pub fn write_all(self, data: &[u8]) -> KernelResult {
+        self.writer().write_slice(data)
+    }
+
+    /// Constructs a [`UserSlicePtrWriter`].
+    pub fn writer(self) -> UserSlicePtrWriter {
+        UserSlicePtrWriter(self.0, self.1)
+    }
+
+    /// Constructs both a [`UserSlicePtrReader`] and a [`UserSlicePtrWriter`].
+    pub fn reader_writer(self) -> (UserSlicePtrReader, UserSlicePtrWriter) {
+        (
+            UserSlicePtrReader(self.0, self.1),
+            UserSlicePtrWriter(self.0, self.1),
+        )
+    }
+}
+
+/// A reader for [`UserSlicePtr`].
+///
+/// Used to incrementally read from the user slice.
+pub struct UserSlicePtrReader(*mut c_types::c_void, usize);
+
+impl UserSlicePtrReader {
+    /// Returns the number of bytes left to be read from this.
+    ///
+    /// Note that even reading less than this number of bytes may fail.
+    pub fn len(&self) -> usize {
+        self.1
+    }
+
+    /// Returns `true` if `self.len()` is 0.
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Reads all data remaining in the user slice.
+    ///
+    /// Returns `EFAULT` if the address does not currently point to
+    /// mapped, readable memory.
+    pub fn read_all(&mut self) -> KernelResult<Vec<u8>> {
+        let mut data = Vec::<u8>::new();
+        data.try_reserve_exact(self.1)?;
+        data.resize(self.1, 0);
+        // SAFETY: The output buffer is valid as we just allocated it.
+        unsafe { self.read_raw(data.as_mut_ptr(), data.len())? };
+        Ok(data)
+    }
+
+    /// Reads a byte slice from the user slice.
+    ///
+    /// Returns `EFAULT` if the byte slice is bigger than the remaining size
+    /// of the user slice or if the address does not currently point to mapped,
+    /// readable memory.
+    pub fn read_slice(&mut self, data: &mut [u8]) -> KernelResult {
+        // SAFETY: The output buffer is valid as it's coming from a live reference.
+        unsafe { self.read_raw(data.as_mut_ptr(), data.len()) }
+    }
+
+    /// Reads raw data from the user slice into a raw kernel buffer.
+    ///
+    /// # Safety
+    ///
+    /// The output buffer must be valid.
+    pub unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> KernelResult {
+        if len > self.1 || len > u32::MAX as usize {
+            return Err(Error::EFAULT);
+        }
+        let res = rust_helper_copy_from_user(out as _, self.0, len as _);
+        if res != 0 {
+            return Err(Error::EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program,
+        // we cannot use `add`, which has C-style rules for defined
+        // behavior.
+        self.0 = self.0.wrapping_add(len);
+        self.1 -= len;
+        Ok(())
+    }
+
+    /// Reads the contents of a plain old data (POD) type from the user slice.
+    pub fn read<T: ReadableFromBytes>(&mut self) -> KernelResult<T> {
+        let mut out = MaybeUninit::<T>::uninit();
+        // SAFETY: The buffer is valid as it was just allocated.
+        unsafe { self.read_raw(out.as_mut_ptr() as _, size_of::<T>()) }?;
+        // SAFETY: We just initialised the data.
+        Ok(unsafe { out.assume_init() })
+    }
+}
+
+/// A writer for [`UserSlicePtr`].
+///
+/// Used to incrementally write into the user slice.
+pub struct UserSlicePtrWriter(*mut c_types::c_void, usize);
+
+impl UserSlicePtrWriter {
+    /// Returns the number of bytes left to be written from this.
+    ///
+    /// Note that even writing less than this number of bytes may fail.
+    pub fn len(&self) -> usize {
+        self.1
+    }
+
+    /// Returns `true` if `self.len()` is 0.
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Writes a byte slice to the user slice.
+    ///
+    /// Returns `EFAULT` if the byte slice is bigger than the remaining size
+    /// of the user slice or if the address does not currently point to mapped,
+    /// writable memory.
+    pub fn write_slice(&mut self, data: &[u8]) -> KernelResult {
+        // SAFETY: The input buffer is valid as it's coming from a live reference.
+        unsafe { self.write_raw(data.as_ptr(), data.len()) }
+    }
+
+    /// Writes raw data to the user slice from a raw kernel buffer.
+    ///
+    /// # Safety
+    ///
+    /// The input buffer must be valid.
+    unsafe fn write_raw(&mut self, data: *const u8, len: usize) -> KernelResult {
+        if len > self.1 || len > u32::MAX as usize {
+            return Err(Error::EFAULT);
+        }
+        let res = rust_helper_copy_to_user(self.0, data as _, len as _);
+        if res != 0 {
+            return Err(Error::EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program,
+        // we cannot use `add`, which has C-style rules for defined
+        // behavior.
+        self.0 = self.0.wrapping_add(len);
+        self.1 -= len;
+        Ok(())
+    }
+
+    /// Writes the contents of the given data into the user slice.
+    pub fn write<T: WritableToBytes>(&mut self, data: &T) -> KernelResult<()> {
+        // SAFETY: The input buffer is valid as it's coming from a live
+        // reference to a type that implements `WritableToBytes`.
+        unsafe { self.write_raw(data as *const T as _, size_of::<T>()) }
+    }
+}
-- 
2.17.1

